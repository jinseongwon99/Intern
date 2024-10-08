	package com.spring.board.service.impl;
	
	import java.util.List;
	
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Service;
	
	import com.spring.board.dao.BoardDao;
	import com.spring.board.service.boardService;
	import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;
	
	@Service
	public class boardServiceImpl implements boardService{
		
		@Autowired
		BoardDao boardDao;
		
	
		@Override
		public String selectTest() throws Exception {
			// TODO Auto-generated method stub
			return boardDao.selectTest();
		}
		
		@Override
		public List<BoardVo> boardList(PageVo pageVo) throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.boardList(pageVo);
		}
		
		@Override
		public List<ComCodeVo> codeList() throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.codeList();
		}
		
		@Override
		public int boardTotal(PageVo pageVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.boardTotal(pageVo);
		}
		
		@Override
		public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
			// TODO Auto-generated method stub
			BoardVo boardVo = new BoardVo();
			
			boardVo.setBoardType(boardType);
			boardVo.setBoardNum(boardNum);
			
			return boardDao.selectBoard(boardVo);
		}
		
		@Override
		public int boardInsert(BoardVo boardVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.boardInsert(boardVo);
		}
		@Override
		public int boardUpdate(BoardVo boardVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.boardUpdate(boardVo);
		}
		
		@Override
		public int boardDelete(BoardVo boardVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.boardDelete(boardVo);
		}
		
		@Override
		public List<UserInfoVo> userList() throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.userList();
		}
		
		@Override
		public int joinInsert(UserInfoVo UserInfoVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.joinInsert(UserInfoVo);
		}
		
		@Override
		public UserInfoVo login(UserInfoVo UserInfoVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.login(UserInfoVo);
		}
		@Override
		public int idCheck(String userid) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.idCheck(userid);
		}
		
		@Override
		public List<ComCodeVo> phoneList() throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.phoneList();
		}
		
		@Override
		public List<BoardVo> QuestionList() throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.QuestionList();
		}
		
		@Override
		public int recruitInsert(RecruitVo recruitVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.recruitInsert(recruitVo);
		}
		
		@Override
		public String Check(RecruitVo recruitVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.Check(recruitVo);
		}
		
		@Override
		public int UpdateRecruit(RecruitVo recruitVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.UpdateRecruit(recruitVo);
		}
		
		@Override
		public int InsertEducation(EducationVo educationVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.InsertEducation(educationVo);
		}
		
		@Override
		public int InsertCareer(CareerVo careerVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.InsertCareer(careerVo);
		}
		
		@Override
		public int InsertCertificate(CertificateVo certificateVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.InsertCertificate(certificateVo);
		}
		

		@Override
		public List<RecruitVo> recruitList(String seq) throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.recruitList(seq);
		}
		
		@Override
		public List<EducationVo> educationList(String seq) throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.educationList(seq);
		}
		
		@Override
		public List<CareerVo> careerList(String seq) throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.careerList(seq);
		}
		
		@Override
		public List<CertificateVo> certificateList(String seq) throws Exception {
			// TODO Auto-generated method stub
			
			return boardDao.certificateList(seq);
		}
		@Override
		public int UpdateEducation(EducationVo educationVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.UpdateEducation(educationVo);
		}
		
		@Override
		public int UpdateCareer(CareerVo careerVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.UpdateCareer(careerVo);
		}
		
		@Override
		public int UpdateCertificate(CertificateVo certificateVo) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.UpdateCertificate(certificateVo);
		}
		
		@Override
		public int educationDelete(String eduseq) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.educationDelete(eduseq);
		}
		
		@Override
		public int careerDelete(String carseq) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.careerDelete(carseq);
		}
		
		@Override
		public int certificateDelete(String certseq) throws Exception {
			// TODO Auto-generated method stub
			return boardDao.certificateDelete(certseq);
		}
		
	 @Override
	    public EducationVo GetEducationByEduSeq(String eduseq) {
	        return boardDao.GetEducationByEduSeq(eduseq);
	    }

	    @Override
	    public CareerVo GetCareerByCarSeq(String carseq) {
	        return boardDao.GetCareerByCarSeq(carseq);
	    }

	    @Override
	    public CertificateVo GetCertificateByCertSeq(String certseq) {
	        return boardDao.GetCertificateByCertSeq(certseq);
	    }
		
	}
