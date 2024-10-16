package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> boardList(PageVo pageVo) throws Exception;
	
	public List<ComCodeVo> codeList() throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int boardTotal(PageVo pageVo) throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;

	public List<UserInfoVo> userList() throws Exception;

	public int joinInsert(UserInfoVo UserInfoVo) throws Exception;
	
	public UserInfoVo login(UserInfoVo UserInfoVo) throws Exception;
	
	public int idCheck(String userid) throws Exception;
	
	public List<ComCodeVo> phoneList() throws Exception;
	
	public List<BoardVo> QuestionList() throws Exception;
	
	public int recruitInsert(RecruitVo recruitVo) throws Exception;
	
	public String Check(RecruitVo recruitVo) throws Exception;
	
	public int UpdateRecruit(RecruitVo recruitVo) throws Exception;

	public int InsertEducation(EducationVo educationVo) throws Exception;

	public int InsertCareer(CareerVo careerVo) throws Exception;
	
	public int InsertCertificate(CertificateVo certificateVo) throws Exception;
	
	public List<RecruitVo> recruitList(String seq) throws Exception;
	
	public List<EducationVo> educationList(String seq) throws Exception;
	
	public List<CareerVo> careerList(String seq) throws Exception;
	
	public List<CertificateVo> certificateList(String seq) throws Exception;

	public int UpdateEducation(EducationVo educationVo) throws Exception;

	public int UpdateCareer(CareerVo careerVo) throws Exception;
	
	public int UpdateCertificate(CertificateVo certificateVo) throws Exception;

	public int educationDelete(String eduseq) throws Exception;
	
	public int careerDelete(String carseq) throws Exception;
	
	public int certificateDelete(String certseq) throws Exception;
	
     EducationVo GetEducationByEduSeq(String eduseq);
    
     CareerVo GetCareerByCarSeq(String carseq);
    
     CertificateVo GetCertificateByCertSeq(String certseq);
}
