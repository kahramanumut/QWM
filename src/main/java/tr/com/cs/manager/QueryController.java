/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tr.com.cs.manager;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tr.com.cs.Entity.CsautPermission;
import tr.com.cs.Entity.CsautRolePermission;
import tr.com.cs.Entity.Permission;
import tr.com.cs.Util.QueryManagerConstants;
import tr.com.cs.Util.QueryManagerUtil;
import tr.com.cs.config.SpringWebConfig;

@Controller
public class QueryController {

    @Autowired
    SpringWebConfig config;
    @Autowired
    QueryManagerUtil managerUtil;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(Map<String, Object> model) {
        return "index";
    }

    @RequestMapping(value = "/generatequery", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject generateQuery(String name, String lastOid) throws IOException {

        File file = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTPERMISSION_FILE_PATH));
        List<String> lines = managerUtil.getLinesFromFile(file);
        HashMap<String, Permission> map = managerUtil.getClassFromLines(lines, CsautPermission.class);
        String findResult = managerUtil.getQueryFromCsautPermissionByName(map, name);
        JSONObject res = new JSONObject();
        List<String> queryAndOid = managerUtil.generateCsautPermissionQuery(map, name, lastOid);
        if (StringUtils.isEmpty(findResult)) {
            res.put("Query", queryAndOid.get(1));
            res.put("OID", queryAndOid.get(0));
        } else {
            res.put("Query", "");
        }
        return res;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject searchByName(String name) throws IOException {
        File file = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTPERMISSION_FILE_PATH));
        List<String> lines = managerUtil.getLinesFromFile(file);
        HashMap<String, Permission> map = managerUtil.getClassFromLines(lines, CsautPermission.class);
        String findResult = managerUtil.getQueryFromCsautPermissionByName(map, name);
        JSONObject res = new JSONObject();
        List<String> queryAndOid = new ArrayList<String>();
        String lastOid = "";
        String secondLine = "";
        int counter = 0;
        if (!StringUtils.isEmpty(findResult)) {
            for (int i = 0; i < findResult.length(); i++) {
                if (findResult.charAt(i) == '\n') {
                    counter++;
                }
                if (counter == 1 && findResult.charAt(i) != '\n') {
                    secondLine += findResult.charAt(i);
                }
            }
            lastOid = managerUtil.getTextFromPermissionQuery(secondLine, 8);
            queryAndOid.add(lastOid);
            queryAndOid.add(findResult);
            if (StringUtils.isEmpty(findResult)) {
                res.put("Query", "");
            } else {
                res.put("Query", queryAndOid.get(1));
                res.put("OID", queryAndOid.get(0));
            }
        } else {
            res.put("message", "Bu kayıt bulunamadı");
        }
        return res;
    }

    @RequestMapping(value = "/save", method = RequestMethod.GET)
    public @ResponseBody
    void save(String queryList, String roleQueryList) throws IOException {
        SimpleDateFormat dt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        try {
            List<String> linesQuery = new ArrayList<String>();
            List<String> linesRoleQuery = new ArrayList<String>();
            org.json.JSONObject jsonObjQuery = new org.json.JSONObject(queryList);
            File fileQuery = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTPERMISSION_FILE_PATH));

            linesQuery = managerUtil.getLinesFromFile(fileQuery);
            linesQuery.add(linesQuery.size(), QueryManagerConstants.QUERY_VERSION_START + dt.format(new Date()) + QueryManagerConstants.QUERY_VERSION_FINISH);
            for (int i = 0; i < jsonObjQuery.length(); i++) {
                linesQuery.add(jsonObjQuery.getString(String.valueOf(i)));
            }
            org.json.JSONObject jsonObjroleQuery = new org.json.JSONObject(roleQueryList);
            File fileRoleQuery = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTROLEPERMISSION_FILE_PATH));

            linesRoleQuery = managerUtil.getLinesFromFile(fileRoleQuery);
            linesRoleQuery.add(linesRoleQuery.size(), QueryManagerConstants.QUERY_VERSION_START + dt.format(new Date()) + QueryManagerConstants.QUERY_VERSION_FINISH);
            for (int k = 0; k < jsonObjroleQuery.length(); k++) {
                linesRoleQuery.add(jsonObjroleQuery.getString(String.valueOf(k)));
            }

            managerUtil.writeLinesToFile(linesQuery, config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTPERMISSION_FILE_PATH));
            managerUtil.writeLinesToFile(linesRoleQuery, config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTROLEPERMISSION_FILE_PATH));

        } catch (JSONException ex) {

        }
    }

    @RequestMapping(value = "/generateRoleQuery", method = RequestMethod.GET)
    public @ResponseBody
    JSONArray generateRoleQuery(String roleOidList, String ekrandanGelenOid, String permissionOid) throws IOException {
        List<String> roleList = Arrays.asList(roleOidList.split(","));
        File file = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTROLEPERMISSION_FILE_PATH));
        List<String> lines = managerUtil.getLinesFromFile(file);
        HashMap<String, Permission> map = managerUtil.getClassFromLines(lines, CsautRolePermission.class);
        JSONArray array = new JSONArray();
        for (String roleOid : roleList) {
            List<String> queryAndOid = managerUtil.generateCsautRolePermissionQuery(map, permissionOid, roleOid, ekrandanGelenOid);
            JSONObject res = new JSONObject();
            res.put("Query", queryAndOid.get(1));
            res.put("lastOid", queryAndOid.get(0));
            array.add(res);
            ekrandanGelenOid = queryAndOid.get(0);
        }
        return array;
    }

    @RequestMapping(value = "/getOptionsOnLoad", method = RequestMethod.GET)
    public @ResponseBody
    JSONArray getOptionsOnLoad() throws IOException, FileNotFoundException, JSONException, ParseException {
        File file = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.OPTIONS_PATH));
        BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
        String line = "";
        JSONArray array = new JSONArray();
        while ((line = reader.readLine()) != null) {
            JSONObject json = (JSONObject) new JSONParser().parse(line);
            json.get("value");
            json.get("name");
            array.add(json);
        }
        return array;
    }

    private TreeMap treeMap;
    private TreeMap treeMap2;
    @RequestMapping(value = "/sortDate", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject sortByDate(String firstDate) throws IOException {
        
        File file = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTPERMISSION_FILE_PATH));
        File file2 = new File(config.getValue(QueryManagerConstants.ROOT_PATH) + config.getValue(QueryManagerConstants.CSAUTROLEPERMISSION_FILE_PATH));
        List<String> lines = managerUtil.getLinesFromFile(file);
        List<String> roleLines = managerUtil.getLinesFromFile(file2);

        String startConstantAndDate = QueryManagerConstants.QUERY_VERSION_START + firstDate;

        int linesCounter = managerUtil.getQueryFromCsautPermissionBySortDate(lines, startConstantAndDate);
        int roleLinesCounter = managerUtil.getQueryFromCsautPermissionBySortDate(roleLines, startConstantAndDate);

        HashMap<String, Permission> map = managerUtil.getClassFromLines(lines.subList(linesCounter, lines.size()), CsautPermission.class);
        treeMap = new TreeMap(map);
        List<String> queryList = new ArrayList<String>();
        for (Object permission : treeMap.values()) {
            CsautPermission csautPermission = (CsautPermission) permission;
            queryList.add(csautPermission.getQuery());
        }
 
        HashMap<String, Permission> map2 = managerUtil.getClassFromLines(roleLines.subList(roleLinesCounter, roleLines.size()), CsautRolePermission.class);
        treeMap2 = new TreeMap(map2);
        List<String> roleList = new ArrayList<String>();
        for (Object permission : treeMap2.values()) {
            CsautRolePermission csautRolePermission = (CsautRolePermission) permission;
            roleList.add(csautRolePermission.getQuery());
        }      
        JSONObject res = new JSONObject();
        res.put("Query", queryList);
        res.put("roleQuery", roleList);
        return res;
    }
}
