package com.spring.board.vo;

import java.util.Map;

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
}
