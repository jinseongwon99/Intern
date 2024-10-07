package com.spring.board.vo;

import java.util.Map;

public class RecruitVo {
	private String seq;
	private String name;
	private String birth;
	private String gender;
	private String phone;
	private String email;
	private String addr;
	private String recruitlocation;
	private String worktype;
	private String submit;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getRecruitlocation() {
		return recruitlocation;
	}
	public void setRecruitlocation(String recruitlocation) {
		this.recruitlocation = recruitlocation;
	}
	public String getWorktype() {
		return worktype;
	}
	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}
	public String getSubmit() {
		return submit;
	}
	public void setSubmit(String submit) {
		this.submit = submit;
	}
	
	 public static RecruitVo fromMap(Map<String, Object> map) {
	        RecruitVo recruitVo = new RecruitVo();
	        recruitVo.setSeq((String) map.get("seq"));
	        recruitVo.setName((String) map.get("name"));
	        recruitVo.setPhone((String) map.get("phone"));
	        recruitVo.setBirth((String) map.get("birth"));
	        recruitVo.setGender((String) map.get("gender"));
	        recruitVo.setEmail((String) map.get("email"));
	        recruitVo.setAddr((String) map.get("addr"));
	        recruitVo.setRecruitlocation((String) map.get("recruitlocation"));
	        recruitVo.setWorktype((String) map.get("worktype"));
	        recruitVo.setSubmit((String) map.get("submit"));
	        return recruitVo;
	    }
	
}
