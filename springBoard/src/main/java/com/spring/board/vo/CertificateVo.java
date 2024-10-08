package com.spring.board.vo;

import java.util.Map;
import java.util.Objects;

public class CertificateVo {

	private String certseq;
	private String seq;
	private String qualifiname;
	private String acqudate;
	private String organizename;
	
	public String getCertseq() {
		return certseq;
	}
	public void setCertseq(String certseq) {
		this.certseq = certseq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getQualifiname() {	
		return qualifiname;
	}
	public void setQualifiname(String qualifiname) {
		this.qualifiname = qualifiname;
	}
	public String getAcqudate() {
		return acqudate;
	}
	public void setAcqudate(String acqudate) {
		this.acqudate = acqudate;
	}
	public String getOrganizename() {
		return organizename;
	}
	public void setOrganizename(String organizename) {
		this.organizename = organizename;
	}
	
	public static CertificateVo fromMap(Map<String, Object> map) {
        CertificateVo certificateVo = new CertificateVo();
        certificateVo.setQualifiname((String) map.get("qualifiname"));
        certificateVo.setAcqudate((String) map.get("acqudate"));
        certificateVo.setOrganizename((String) map.get("organizename"));
        return certificateVo;
    }
	

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof CertificateVo)) return false;
        CertificateVo other = (CertificateVo) obj;
        return 
               Objects.equals(seq, other.seq) &&
               Objects.equals(qualifiname, other.qualifiname) &&
               Objects.equals(acqudate, other.acqudate) &&
               Objects.equals(organizename, other.organizename);
    }

    @Override
    public int hashCode() {
        return Objects.hash(certseq, seq, qualifiname, acqudate, organizename);
    }

    @Override
    public String toString() {
        return "CertificateVo {" +
               ", seq='" + seq + '\'' +
               ", qualifiname='" + qualifiname + '\'' +
               ", acqudate='" + acqudate + '\'' +
               ", organizename='" + organizename + '\'' +
               '}';
    }
}
