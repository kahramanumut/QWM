/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tr.com.cs.Util;

import tr.com.cs.Entity.CsautPermission;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tr.com.cs.Entity.CsautRolePermission;
import tr.com.cs.Entity.Permission;
import tr.com.cs.config.SpringWebConfig;

/**
 *
 * @author umutk
 */
@Service
public class QueryManagerUtil {

    @Autowired
    SpringWebConfig config;

    public List<String> getLinesFromFile(File file) throws FileNotFoundException, IOException {
        BufferedReader reader = new BufferedReader(new FileReader(file.getPath()));
        List<String> lines = new ArrayList<String>();
        String line;
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
        return lines;
    }

    public HashMap<String, Permission> getClassFromLines(List<String> lines, Class clazz) {
        HashMap<String, Permission> map = new HashMap<String, Permission>();
        int i = 0;
        if (clazz == CsautPermission.class) {

            CsautPermission csautPermission = new CsautPermission();
            String query = "";
            for (String line : lines) {
                if (line.startsWith(QueryManagerConstants.QUERY_VERSION_START)) {
                    i = 0;
                } else if (i == 1) {
                    csautPermission.setOid(getTextFromPermissionQuery(line, QueryManagerConstants.QUERY_VALUES_LENGTH));
                    csautPermission.setName(getTextFromPermissionQuery(line, QueryManagerConstants.QUERY_VALUES_AND_OID_LENGTH));
                    query += "\n" + line;
                    i++;
                } else if (i == 0) {
                    query += line;
                    i++;
                } else if (i == 2) {
                    query += "\n" + line;
                    csautPermission.setQuery(query);
                    map.put(csautPermission.getOid(), csautPermission);
                    i = 0;
                    query = "";
                    csautPermission = new CsautPermission();
                }
            }
        } else if (clazz == CsautRolePermission.class) {
            CsautRolePermission csautRolePermission = new CsautRolePermission();
            String query = "";
            for (String line : lines) {
                if (line.startsWith(QueryManagerConstants.QUERY_VERSION_START)) {
                    i = 0;
                } else if (i == 1) {
                    csautRolePermission.setOid(getTextFromPermissionQuery(line, QueryManagerConstants.QUERY_VALUES_LENGTH));
                    csautRolePermission.setPermissionOid(getTextFromPermissionQuery(line, QueryManagerConstants.QUERY_VALUES_AND_OID_LENGTH));
                    csautRolePermission.setRoleOid(getTextFromPermissionQuery(line, QueryManagerConstants.ROLE_VALUES_AND_OID_LENGTH));
                    query += "\n" + line;
                    i++;
                } else if (i == 0) {
                    query += line;
                    i++;
                } else if (i == 2) {
                    query += "\n" + line;
                    csautRolePermission.setQuery(query);
                    map.put(csautRolePermission.getOid(), csautRolePermission);
                    i = 0;
                    query = "";
                    csautRolePermission = new CsautRolePermission();
                }
            }
        }

        return map;
    }

    public String getTextFromPermissionQuery(String line, int keyLength) {
        String key = "";
        for (int i = keyLength; line.charAt(i) != '\''; i++) {  //VALUES('  uzunluğu 8 karakter
            key += line.charAt(i);
        }
        return key;
    }

    public String writeLinesToFile(List<String> lines, String path) throws IOException {
        File file = new File(path);
        file.delete();
        int i = 0;
        FileWriter writer = new FileWriter(path);
        for (String line : lines) {
            i++;
            writer.write(line);
            if (i != lines.size()) {
                writer.write('\n');
            }
        }
        writer.close();
        return null;
    }

    public String getQueryFromCsautPermissionByName(HashMap<String, Permission> map, String name) {
        for (Permission csautPermission : map.values()) {
            CsautPermission per = (CsautPermission) csautPermission;
            if (per.getName().equals(name)) {
                return per.getQuery();
            }
        }
        return null;
    }
//Sort Date 

    public int getQueryFromCsautPermissionBySortDate(List<String> lines, String queryConstant) {
        int linesCounter = 0;
        int i=0;
        while(lines.get(i).startsWith(queryConstant)==false)
        {
        linesCounter++;
        i++;
        }
        return linesCounter;
    }

    public String getQueryFromCsautPermissionByOid(HashMap<String, CsautPermission> map, String oid) {
        CsautPermission csautPermission = map.get(oid);
        if (csautPermission != null) {
            return csautPermission.getQuery();
        }
        return null;
    }

    public String generateOid(Map<String, Permission> map, String ekrandanGelenOid, String prefix, int prefixLength) {
        String oid = "";
        List<String> keyList = new ArrayList<String>();
        for (String key : map.keySet()) {
            if (key.indexOf(prefix) == 0) {
                keyList.add(key);
            }
        }
        Collections.sort(keyList);
        int ekrandanGelenOidInt = -1;
        if (!ekrandanGelenOid.isEmpty()) {
            ekrandanGelenOid = ekrandanGelenOid.substring(prefixLength);
            ekrandanGelenOidInt = Integer.parseInt(ekrandanGelenOid);
        }
        String lastOid = keyList.get(keyList.size() - 1);
        lastOid = lastOid.substring(prefixLength);
        int oidInt = Integer.parseInt(lastOid);
        if (ekrandanGelenOidInt > oidInt) {
            oid = generateOidByPrefix(ekrandanGelenOidInt, prefixLength, prefix);
        } else {
            oid = generateOidByPrefix(oidInt, prefixLength, prefix);
        }
        return oid;
    }

    public List<String> generateCsautPermissionQuery(Map<String, Permission> map, String name, String lastOid) {
        List<String> myList = new ArrayList<String>();
        String query = QueryManagerConstants.QUERY_INSERT;
        String pref = config.getValue(QueryManagerConstants.CSAUTPERMISSION_OID_PREF);
        String oid = generateOid(map, lastOid, pref, QueryManagerConstants.CSAUTPERMISSION_OID_PREF_LENGTH);
        query += "'" + oid + "','" + name + "','" + QueryManagerConstants.QUERY_INSERT_DATE + "')\nGO";
        myList.add(oid);
        myList.add(query);

        return myList;
    }

    public List<String> generateCsautRolePermissionQuery(HashMap<String, Permission> map, String perOid, String roleOid, String ekrandanGelenOid) {
        List<String> myList = new ArrayList<String>();
        String query = QueryManagerConstants.QUERY_ROLE_INSERT;
        String oid = generateOid(map, ekrandanGelenOid, config.getValue(QueryManagerConstants.CSAUTROLEPERMISSION_OID_PREF), QueryManagerConstants.CSAUTROLEPERMISSION_OID_PREF_LENGTH);
        query += "'" + oid + "','" + perOid + "','" + roleOid + "', '', '1753-01-01 00:00:00.0', '9999-12-31 00:00:00.0')\nGO";
        myList.add(oid);
        myList.add(query);
        return myList;
    }

    private String generateOidByPrefix(int oidInt, int prefixLength, String prefiz) {
        oidInt++;
        String oid = "";
        String lastOid = Integer.toString(oidInt);
        int lengthOfNonZeroNumbers = lastOid.length();
        for (int i = 0; i < QueryManagerConstants.QUERY_OID_LENGTH - prefixLength - lengthOfNonZeroNumbers; i++) {
            oid += "0";
        }
        oid += lastOid;
        oid = prefiz + oid;
        return oid;
    }
}
