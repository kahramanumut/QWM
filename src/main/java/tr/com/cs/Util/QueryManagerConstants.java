/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tr.com.cs.Util;

/**
 *
 * @author umutk
 */
public class QueryManagerConstants {

    //-----Csautpermission
    public static final String CSAUTPERMISSION_FILE_PATH = "csaut.permission.file.path";
    public static final int CSAUTPERMISSION__QUERY_ROW_LENGTH = 3;  //satır sayısı
    public static final int CSAUTPERMISSION__QUERY_OID_OFFSET = 11;  //
    public static final String CSAUTPERMISSION_OID_PREF = "csautpermission_oid_pref";
    public static final int CSAUTPERMISSION_OID_PREF_LENGTH = 6;     //FINPER uzunluğu
    //-----Query
    public static final int QUERY_VALUES_LENGTH = 8; //VALUES('  karakter sayısı
    public static final int QUERY_VALUES_AND_OID_LENGTH = 25; //VALUES(' + FINPER uzunluğu
    public static final int QUERY_OID_LENGTH = 14;                  //OID uzunluğu
    public static final String QUERY_INSERT = "INSERT INTO CSAUT_PERMISSION([OID], [NAME], [CREATION_TIME])" + "\n" + "VALUES(";
    public static final String QUERY_VERSION_START = "/* <-------------------";
    public static final String QUERY_VERSION_FINISH = "-------------------> */";
    public static final String QUERY_INSERT_DATE = "2013-10-21 21:04:41.467";
    public static final String QUERY_ROLE_INSERT = "INSERT INTO [dbo].[CSAUT_ROLE_PERMISSION]([OID], [PERMISSION_OID], [ROLE_OID], [ACCESS_MODE], [START_TIME], [EXPIRATION_TIME])" + "\n" + "VALUES(";
    //-----CsautRolepermission
    public static final String CSAUTROLEPERMISSION_FILE_PATH = "csautrole.permission.file.path";
    public static final int QUERY_ROLE_OID_LENGTH = 14;  //Role OID uzunluğu
    public static final int CSAUTROLEPERMISSION__QUERY_OID_OFFSET = 12; //values + tırnaklar
    public static final int ROLE_VALUES_AND_OID_LENGTH = 40;
    public static final String CSAUTROLEPERMISSION_OID_PREF = "csautrolepermission_oid_pref";
    public static final int CSAUTROLEPERMISSION_OID_PREF_LENGTH = 7;  //FINDBSS uzunluğu
    
    public static final String OPTIONS_PATH = "options.path";
    public static final String ROOT_PATH = "files.root.path";

}
