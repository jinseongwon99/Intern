package com.spring.common;

import java.io.IOException;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.spring.board.HomeController;

public class CommonUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Gets the json call back string.
	 *
	 * @param callback the callback
	 * @param obj the obj
	 * @return the json call back string
	 * @throws IOException 
	 */

	public static String getJsonCallBackString(String callback, Object obj) throws IOException {
		StringBuffer sb = new StringBuffer();
//		sb.append(callback).append("(");

		sb.append(toJson(obj));

//		sb.append(")");
		return sb.toString();
	}
	
	/**
	 * To json.
	 *
	 * @param obj the obj
	 * @return the string
	 * @throws IOException 
	 */
	public static String toJson(Object obj) throws IOException {
		String rtnStr = "";
		//create ObjectMapper instance
        ObjectMapper objectMapper = new ObjectMapper();

        //configure Object mapper for pretty print
//        objectMapper.configure(SerializationFeature.INDENT_OUTPUT, true);

        try {
        	rtnStr = objectMapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			logger.debug("toJson parsing Error",e);
		}
        return rtnStr;
	}
}
