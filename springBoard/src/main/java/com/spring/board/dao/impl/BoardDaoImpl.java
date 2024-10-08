package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> boardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public List<ComCodeVo> codeList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.codeList");
	}
	
	@Override
	public int boardTotal(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal",pageVo);
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.boardDelete", boardVo);
	}

	@Override
	public List<UserInfoVo> userList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.userList");
	}
	
	@Override
	public int joinInsert(UserInfoVo UserInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.joinInsert", UserInfoVo);
	}
	
	@Override
	public UserInfoVo login(UserInfoVo UserInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.login", UserInfoVo);
	}
	
	@Override
	public int idCheck(String userid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.idCheck", userid);
	}
	
	@Override
	public List<ComCodeVo> phoneList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.phoneList");
	}
	
	@Override
	public List<BoardVo> QuestionList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.QuestionList");
	}
	
	@Override
	public int recruitInsert(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.recruitInsert", recruitVo);
	}
	
	@Override
	public String Check(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.Check",recruitVo);
	}
	
	@Override
	public int UpdateRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.UpdateRecruit", recruitVo);
	}

	
	@Override
	public int InsertEducation(EducationVo educationVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.InsertEducation", educationVo);
	}
	
	@Override
	public int InsertCareer(CareerVo careerVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.InsertCareer", careerVo);
	}
	
	@Override
	public int InsertCertificate(CertificateVo certificateVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.InsertCertificate", certificateVo);
	}

	@Override
	public List<RecruitVo> recruitList(String seq) throws Exception {
	    return sqlSession.selectList("board.recruitList", seq);
	}

	@Override
	public List<EducationVo> educationList(String seq) throws Exception {
	    return sqlSession.selectList("board.educationList", seq);
	}

	@Override
	public List<CareerVo> careerList(String seq) throws Exception {
	    return sqlSession.selectList("board.careerList", seq);
	}

	@Override
	public List<CertificateVo> certificateList(String seq) throws Exception {
	    return sqlSession.selectList("board.certificateList", seq);
	}

	@Override
	public int UpdateEducation(EducationVo educationVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.UpdateEducation", educationVo);
	}

	
	@Override
	public int UpdateCareer(CareerVo careerVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.UpdateCareer", careerVo);
	}

	
	@Override
	public int UpdateCertificate(CertificateVo certificateVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.UpdateCertificate", certificateVo);
	}

	@Override
	public int educationDelete(String eduseq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.educationDelete", eduseq);
	}
	
	@Override
	public int careerDelete(String carseq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.careerDelete", carseq);
	}
	
	@Override
	public int certificateDelete(String certseq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.certificateDelete", certseq);
	}
	
   @Override
    public EducationVo GetEducationByEduSeq(String eduseq) {
        return sqlSession.selectOne("GetEducationByEduSeq", eduseq);
    }

    @Override
    public CareerVo GetCareerByCarSeq(String carseq) {
        return sqlSession.selectOne("GetCareerByCarSeq", carseq);
    }

    @Override
    public CertificateVo GetCertificateByCertSeq(String certseq) {
        return sqlSession.selectOne("GetCertificateByCertSeq", certseq);
    }

}
