/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tr.com.cs.Entity;

/**
 *
 * @author umutk
 */
public class CsautRolePermission extends Permission{
    private String oid;
    private String permissionOid;
    private String roleOid;
    private String query;

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }
    
    public String getPermissionOid() {
        return permissionOid;
    }

    public void setPermissionOid(String permissionOid) {
        this.permissionOid = permissionOid;
    }

    public String getRoleOid() {
        return roleOid;
    }

    public void setRoleOid(String roleOid) {
        this.roleOid = roleOid;
    }
    
}
