package com.spring.board.vo;

import java.util.Map;
import java.util.Objects;

public class EducationVo {
	
	private String eduseq;
	private String seq;
	private String schoolname;
	private String division;
	private String startperiod;
	private String endperiod;
	private String major;
	private String grade;
 	private String schoollocation;
	public String getEduseq() {
		return eduseq;
	}
	public void setEduseq(String eduseq) {
		this.eduseq = eduseq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSchoolname() {
		return schoolname;
	}
	public void setSchoolname(String schoolname) {
		this.schoolname = schoolname;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getStartperiod() {
		return startperiod;
	}
	public void setStartperiod(String startperiod) {
		this.startperiod = startperiod;
	}
	public String getEndperiod() {
		return endperiod;
	}
	public void setEndperiod(String endperiod) {
		this.endperiod = endperiod;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getSchoollocation() {
		return schoollocation;
	}
	public void setSchoollocation(String schoollocation) {
		this.schoollocation = schoollocation;
	}
 	

	@Override
	public String toString() {
	    return "{" +
	           "startperiod='" + startperiod + '\'' +
	           ", endperiod='" + endperiod + '\'' +
	           ", division='" + division + '\'' +
	           ", schoolname='" + schoolname + '\'' +
	           ", schoollocation='" + schoollocation + '\'' +
	           ", major='" + major + '\'' +
	           ", grade='" + grade + '\'' +
	           '}';
	}
	
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof EducationVo)) return false;
        EducationVo other = (EducationVo) obj;
        return 
               Objects.equals(schoolname, other.schoolname) &&
               Objects.equals(division, other.division) &&
               Objects.equals(startperiod, other.startperiod) &&
               Objects.equals(endperiod, other.endperiod) &&
               Objects.equals(major, other.major) &&
               Objects.equals(grade, other.grade) &&
               Objects.equals(schoollocation, other.schoollocation);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eduseq, seq, schoolname, division, startperiod, endperiod, major, grade, schoollocation);
    }

	public static EducationVo fromMap(Map<String, Object> map) {
        EducationVo educationVo = new EducationVo();
        educationVo.setSchoolname((String) map.get("schoolname"));
        educationVo.setDivision((String) map.get("division"));
        educationVo.setStartperiod((String) map.get("startperiod"));
        educationVo.setEndperiod((String) map.get("endperiod"));
        educationVo.setMajor((String) map.get("major"));
        educationVo.setGrade((String) map.get("grade"));
        educationVo.setSchoollocation((String) map.get("schoollocation"));
        return educationVo;
    }
	
}
