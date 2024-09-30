package com.spring.board.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	HttpSession session;
	HttpServletRequest request;
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model, PageVo pageVo, 
	        @RequestParam(value = "type", required = false) List<String> selectedTypes, 
	        @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, 
	        HttpSession session) throws Exception {

	    List<BoardVo> boardList;
	    List<ComCodeVo> codeList = boardService.codeList();
	    int totalCnt;

	    pageVo.setPageNo(pageNo);

	    String selectedTypesParam = "";
	    if (selectedTypes != null && !selectedTypes.isEmpty()) {
	        selectedTypesParam = String.join(",", selectedTypes);
	        pageVo.setTypes(selectedTypes);
	        session.setAttribute("selectedTypes", selectedTypesParam); 
	    } else {
	        pageVo.setTypes(new ArrayList<>());
	    }

	    boardList = boardService.boardList(pageVo);
	    totalCnt = boardService.boardTotal(pageVo);

	    int pageSize = 10;
	    int totalPages = (int) Math.ceil((double) totalCnt / pageSize);

	    int pagesPerGroup = 10;
	    int currentGroup = (pageNo - 1) / pagesPerGroup;
	    int startPage = currentGroup * pagesPerGroup + 1;
	    int endPage = Math.min(totalPages, startPage + pagesPerGroup - 1);

	    model.addAttribute("codeList", codeList);
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("totalCnt", totalCnt);
	    model.addAttribute("pageNo", pageNo);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("currentGroup", currentGroup);
	    model.addAttribute("selectedTypesParam", selectedTypesParam); 

	    return "board/boardList";    
	}



	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
	    List<ComCodeVo> codeList = boardService.codeList();
	    
	    model.addAttribute("codeList", codeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardManage.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardManage";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		int resultCnt = boardService.boardUpdate(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();		
		
		int resultCnt = boardService.boardDelete(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	

	@RequestMapping(value = "/board/joinPage.do", method = RequestMethod.GET)
	public String joinPage(Locale locale, Model model) throws Exception{
		
	    List<ComCodeVo> phoneList = boardService.phoneList();
	    
	    model.addAttribute("phoneList", phoneList);
	    
		return "board/joinPage";
	}
	
	@RequestMapping(value = "/board/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String joinAction(Locale locale,UserInfoVo UserInfoVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		int resultCnt = boardService.joinInsert(UserInfoVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/idCheckAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String idCheck(@RequestBody Map<String, String> requestBody) throws Exception {
	    String userId = requestBody.get("userId");

	    HashMap<String, String> result = new HashMap<>();


	    int resultCnt = boardService.idCheck(userId);

	    result.put("success", (resultCnt > 0) ? "Y" : "N");
	    String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);

	    System.out.println("callbackMsg::" + callbackMsg);

	    return callbackMsg;
	}

	@RequestMapping(value = "/board/loginPage.do", method = RequestMethod.GET)
	public String loginPage(Locale locale, Model model) throws Exception{
		
		
		return "board/loginPage";
	}
	
	@RequestMapping(value = "/board/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> loginAction(UserInfoVo userInfoVo, HttpSession session) throws Exception {

	    Map<String, String> result = new HashMap<>();

		if (userInfoVo.getUserId().trim().isEmpty()) {
	        result.put("success", "N");
	        result.put("message", "아이디를 입력하세요.");       
		} else if (userInfoVo.getUserPw().trim().isEmpty()) {
	        result.put("success", "N");
	        result.put("message", "비밀번호를 입력하세요."); 
	    }else {
	        UserInfoVo login = boardService.login(userInfoVo);

	        if (login == null) {
	            result.put("success", "N");
	            result.put("message", "아이디를 확인하세요.");
	        } else if (!userInfoVo.getUserPw().equals(login.getUserPw())) {
	            result.put("success", "N");
	            result.put("message", "비밀번호를 틀립니다.");
	        } else {
	            session.setAttribute("userid", userInfoVo.getUserId()); 
	            result.put("success", "Y");
	            result.put("message", "로그인 성공");
	        }
	    }

	    return result;
	}



	@RequestMapping("/board/logout.do")
	public String logout(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }
	    return "redirect:/board/boardList.do";
	}
	
	@RequestMapping(value = "/board/mbtiPage.do", method = RequestMethod.GET)
	public String mbtiPage(@RequestParam(value = "status", defaultValue = "0") int mbtiStatus, Locale locale, Model model) throws Exception{
	    
	    List<BoardVo> QuestionList = boardService.QuestionList();
	    
	    model.addAttribute("QuestionList", QuestionList);
	    model.addAttribute("mbtiStatus", mbtiStatus); 
	    
	    return "board/mbtiPage";
	}
	@RequestMapping(value = "/board/mbtiCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public void mbtiCheck(@RequestBody Map<String, Object> request, HttpSession session) throws Exception {

	    Map<String, Map<String, String>> answers = (Map<String, Map<String, String>>) request.get("answers");
	    Integer mbtiStatus = (Integer) request.get("mbtiStatus");


	    Map<String, Integer> scores = (Map<String, Integer>) session.getAttribute("scores");

	    if (mbtiStatus == 0) {
	        scores = new HashMap<>();
	        scores.put("E", 0);
	        scores.put("I", 0);
	        scores.put("N", 0);
	        scores.put("S", 0);
	        scores.put("T", 0);
	        scores.put("F", 0);
	        scores.put("J", 0);
	        scores.put("P", 0);
	        session.setAttribute("scores", scores);  
	    }

	    for (Map.Entry<String, Map<String, String>> entry : answers.entrySet()) {
	        String name = entry.getKey();
	        Map<String, String> answer = entry.getValue();

	        String id = answer.get("id");
	        String valueStr = answer.get("value");
	        int value = 0;
	        value = Integer.parseInt(valueStr);
	        String processedId = null;	
	            int score = 0;
	            switch (value) {
	                case 7: processedId = id.substring(0, 1); score = 3; break;
	                case 6: processedId = id.substring(0, 1); score = 2; break;
	                case 5: processedId = id.substring(0, 1); score = 1; break;
	                case 4: processedId = id.substring(0, 0); score = 0; break;
	                case 3: processedId = id.substring(1, 2); score = 1; break;
	                case 2: processedId = id.substring(1, 2); score = 2; break;
	                case 1: processedId = id.substring(1, 2); score = 3; break;
	            }
	            scores.put(processedId, scores.get(processedId) + score);
	        
	    }

	    System.out.println(scores);


	    if (mbtiStatus == 3) {
	        session.setAttribute("E_I", getResult("E", "I", scores.get("E"), scores.get("I")));
	        session.setAttribute("N_S", getResult("N", "S", scores.get("N"), scores.get("S")));
	        session.setAttribute("F_T", getResult("F", "T", scores.get("F"), scores.get("T")));
	        session.setAttribute("J_P", getResult("J", "P", scores.get("J"), scores.get("P")));
	    }
	}

	private String getResult(String label1, String label2, int value1, int value2) {
	    if (value1 > value2) {
	        return label1;
	    } else if (value1 < value2) {
	        return label2;
	    } else {
	        return (label1.compareTo(label2) < 0) ? label1 : label2;
	    }
	}


	@RequestMapping(value = "/board/login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model, HttpSession session, HttpServletResponse response) throws Exception {
	    
		session.invalidate(); 

	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
	    response.setHeader("Pragma", "no-cache");
	    response.setHeader("Expires", "0"); 

	    return "board/login";
	}
	
	@RequestMapping(value = "/board/recruitAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String recruitAction(Locale locale, RecruitVo recruitVo, HttpSession session, Model model) throws Exception {
	   
	    HashMap<String, String> result = new HashMap<>();
	    String seq = boardService.Check(recruitVo);
	    if (seq == null) {
	        int resultCnt = boardService.recruitInsert(recruitVo);
	        result.put("success", (resultCnt > 0) ? "Y" : "N");
	        session.setAttribute("seq", recruitVo.getSeq());	
	    } else {
	        List<RecruitVo> recruitList = boardService.recruitList(seq);
	        List<EducationVo> educationList = boardService.educationList(seq);
	        List<CareerVo> careerList = boardService.careerList(seq);
	        List<CertificateVo> certificateList = boardService.certificateList(seq);

	        session.setAttribute("recruitList", recruitList);
	        session.setAttribute("educationList", educationList);
	        session.setAttribute("careerList", careerList);
	        session.setAttribute("certificateList", certificateList);

	        result.put("success", "K");
	    }

	    session.setAttribute("name", recruitVo.getName());
	    session.setAttribute("phone", recruitVo.getPhone());

	    return CommonUtil.getJsonCallBackString(" ", result);
	}
	@RequestMapping(value = "/board/main.do", method = RequestMethod.GET)
	public String main(Locale locale, Model model, HttpSession session) throws Exception {

	    List<RecruitVo> recruitList = (List<RecruitVo>) session.getAttribute("recruitList");
	    List<EducationVo> educationList = (List<EducationVo>) session.getAttribute("educationList");
	    List<CareerVo> careerList = (List<CareerVo>) session.getAttribute("careerList");
	    List<CertificateVo> certificateList = (List<CertificateVo>) session.getAttribute("certificateList");

	    int totalEducationMonths = 0;
	    if (educationList != null) {
	        for (EducationVo education : educationList) {
	            String startPeriod = education.getStartperiod();
	            String endPeriod = education.getEndperiod();
	            if (startPeriod != null && endPeriod != null) {
	                totalEducationMonths += calculateMonths(startPeriod, endPeriod);
	            }
	        }
	    }

	    int totalCareerMonths = 0;
	    if (careerList != null) {
	        for (CareerVo career : careerList) {
	            String startPeriod = career.getStartperiod();
	            String endPeriod = career.getEndperiod();
	            if (startPeriod != null && endPeriod != null) {
	                totalCareerMonths += calculateMonths(startPeriod, endPeriod);
	            }
	        }
	    }

	    session.setAttribute("totalEducationDuration", formatDuration(totalEducationMonths));
	    session.setAttribute("totalCareerDuration", formatDuration(totalCareerMonths));

	    model.addAttribute("recruitList", recruitList);
	    model.addAttribute("educationList", educationList);
	    model.addAttribute("careerList", careerList);
	    model.addAttribute("certificateList", certificateList);

	    return "board/main";
	}

	private int calculateMonths(String start, String end) {
	    String[] startArr = start.split("-");
	    String[] endArr = end.split("-");
	    return (Integer.parseInt(endArr[0]) - Integer.parseInt(startArr[0])) * 12 +
	           (Integer.parseInt(endArr[1]) - Integer.parseInt(startArr[1]));
	}

	private String formatDuration(int totalMonths) {
	    int years = totalMonths / 12;
	    int months = totalMonths % 12;
	    return (years > 0 ? years + "년 " : "") + (months > 0 ? months + "개월" : "").trim();
	}


	
	@RequestMapping(value = "/board/resumeAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String resumeAction(@RequestBody Map<String, Object> requestData, HttpSession session) throws Exception {
	    HashMap<String, String> result = new HashMap<>();
	    boolean allSuccess = true;

	    Map<String, Object> recruitData = (Map<String, Object>) requestData.get("recruit");
	    RecruitVo recruitVo = new RecruitVo();
	    recruitVo.setSeq((String) recruitData.get("seq"));
	    recruitVo.setName((String) recruitData.get("name"));
	    recruitVo.setPhone((String) recruitData.get("phone"));
	    recruitVo.setBirth((String) recruitData.get("birth"));
	    recruitVo.setGender((String) recruitData.get("gender"));
	    recruitVo.setEmail((String) recruitData.get("email"));
	    recruitVo.setAddr((String) recruitData.get("addr"));
	    recruitVo.setRecruitlocation((String) recruitData.get("recruitlocation"));
	    recruitVo.setWorktype((String) recruitData.get("worktype"));
	    recruitVo.setSubmit((String) recruitData.get("submit"));

	    System.out.println("RecruitVo: " + recruitVo);

	    int recruit = boardService.UpdateRecruit(recruitVo);
	    if (recruit <= 0) {
	        allSuccess = false;
	    }

	    List<Map<String, Object>> educationList = (List<Map<String, Object>>) requestData.get("education");

	    for (Map<String, Object> educationData : educationList) {
	        EducationVo educationVo = new EducationVo();
	        educationVo.setSeq((String) recruitData.get("seq"));
	        educationVo.setSchoolname((String) educationData.get("schoolname"));
	        educationVo.setDivision((String) educationData.get("division"));
	        educationVo.setStartperiod((String) educationData.get("startperiod"));
	        educationVo.setEndperiod((String) educationData.get("endperiod"));
	        educationVo.setMajor((String) educationData.get("major"));
	        educationVo.setGrade((String) educationData.get("grade"));
	        educationVo.setSchoollocation((String) educationData.get("schoollocation"));
	        
	        String eduseq = (String) educationData.get("eduseq");
	        
	        if (eduseq == null || eduseq.trim().isEmpty()) {
	            int Insert = boardService.InsertEducation(educationVo);
	            if (Insert <= 0) {
	                allSuccess = false;
	            }
	        } else {
	            educationVo.setEduseq(eduseq);
	            int update = boardService.UpdateEducation(educationVo); 
	            if (update <= 0) {
	                allSuccess = false;
	            }
	        }
	    }

	    List<Map<String, Object>> careerList = (List<Map<String, Object>>) requestData.get("career");
	    for (Map<String, Object> careerData : careerList) {

	    	if (careerData.get("compname") == null || ((String) careerData.get("compname")).trim().isEmpty() ||
	            careerData.get("careerlocation") == null || ((String) careerData.get("careerlocation")).trim().isEmpty() ||
	            careerData.get("startperiod") == null || ((String) careerData.get("startperiod")).trim().isEmpty() ||
	            careerData.get("endperiod") == null || ((String) careerData.get("endperiod")).trim().isEmpty() ||
	            careerData.get("task") == null || ((String) careerData.get("task")).trim().isEmpty()) {
	            continue; 
	        }

	        CareerVo careerVo = new CareerVo();
	        careerVo.setSeq((String) recruitData.get("seq"));
	        careerVo.setCompname((String) careerData.get("compname"));
	        careerVo.setCareerlocation((String) careerData.get("careerlocation"));
	        careerVo.setStartperiod((String) careerData.get("startperiod"));
	        careerVo.setEndperiod((String) careerData.get("endperiod"));
	        careerVo.setTask((String) careerData.get("task"));
	        
	        String carseq = (String) careerData.get("carseq");

	        if (carseq == null || carseq.trim().isEmpty()) {
	            int Insert = boardService.InsertCareer(careerVo);
	            if (Insert <= 0) {
	                allSuccess = false;
	            }
	        } else {
	          
	            careerVo.setCarseq(carseq);
	            int update = boardService.UpdateCareer(careerVo); 
	            if (update <= 0) {
	                allSuccess = false;
	            }
	        }
	    }

	    
	    List<Map<String, Object>> certificateList = (List<Map<String, Object>>) requestData.get("certificate");

	    for (Map<String, Object> certificateData : certificateList) {
	        
	        if (certificateData.get("qualifiname") == null || ((String) certificateData.get("qualifiname")).trim().isEmpty() ||
	            certificateData.get("acqudate") == null || ((String) certificateData.get("acqudate")).trim().isEmpty() ||
	            certificateData.get("organizename") == null || ((String) certificateData.get("organizename")).trim().isEmpty()) {
	            continue;
	        }

	        CertificateVo certificateVo = new CertificateVo();
	        certificateVo.setSeq((String) recruitData.get("seq"));
	        certificateVo.setQualifiname((String) certificateData.get("qualifiname"));
	        certificateVo.setAcqudate((String) certificateData.get("acqudate"));
	        certificateVo.setOrganizename((String) certificateData.get("organizename"));

	       
	        String certseq = (String) certificateData.get("certseq");

	        if (certseq == null || certseq.trim().isEmpty()) {
	            
	            int insert = boardService.InsertCertificate(certificateVo);
	            System.out.println("Insert Certificate Result: " + insert);
	            if (insert <= 0) {
	                allSuccess = false;
	            }
	        } else {
	           
	            certificateVo.setCertseq(certseq);
	            int update = boardService.UpdateCertificate(certificateVo);
	            if (update <= 0) {
	                allSuccess = false;
	            }
	        }
	    }

	    if (session != null) {
	        session.invalidate();
	    }	    
	    result.put("success", allSuccess ? "Y" : "N");
	    return CommonUtil.getJsonCallBackString(" ", result);

		}

	@RequestMapping(value = "/board/resumeDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String resumeDeleteAction(Locale locale, @RequestBody HashMap<String, List<String>> requestData) throws Exception {
	    HashMap<String, String> result = new HashMap<>();

	    List<String> eduseqList = requestData.get("educationseqList");
	    List<String> carseqList = requestData.get("careerseqList");
	    List<String> certseqList = requestData.get("certificateseqList");

	    if (eduseqList != null && !eduseqList.isEmpty()) {
	        for (String eduseq : eduseqList) {
	            int resultCnt = boardService.educationDelete(eduseq);
	            result.put("education_" + eduseq, (resultCnt > 0) ? "Y" : "N");
	        }
	    }

	    if (carseqList != null && !carseqList.isEmpty()) {
	        for (String carseq : carseqList) {
	            int resultCnt = boardService.careerDelete(carseq);
	            result.put("career_" + carseq, (resultCnt > 0) ? "Y" : "N");
	        }
	    }

	    if (certseqList != null && !certseqList.isEmpty()) {
	        for (String certseq : certseqList) {
	            int resultCnt = boardService.certificateDelete(certseq);
	            result.put("certificate_" + certseq, (resultCnt > 0) ? "Y" : "N");
	        }
	    }


	    String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);
	    
	    return callbackMsg;
	}

	
}