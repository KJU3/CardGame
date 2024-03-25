<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ page
import="java.util.Enumeration"%> 현재 점수는 ${param.score} <% System.out.println(request.getParameter("score"));
System.out.println(request.getMethod()); %>
