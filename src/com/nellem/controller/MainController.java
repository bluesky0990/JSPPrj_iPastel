package com.nellem.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nellem.command.BInsertCommand;
import com.nellem.command.BListCommand;
import com.nellem.command.BViewCommand;
import com.nellem.command.InterfaceCommand;
import com.nellem.command.MInsertCommand;
import com.nellem.command.MLoginCommand;

@WebServlet("*.do")
public class MainController extends HttpServlet {
	private void doHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String viewPage = null;
		InterfaceCommand command = null;
		
		String uri = request.getRequestURI(); 	//uri :/member-mvc/list.do
		String com= uri.substring(uri.lastIndexOf("/")+ 1, uri.lastIndexOf(".do")); //command :insert
		
		if(com !=null && com.trim().equals("index")) {
			viewPage = "/WEB-INF/view/index.jsp";
		}
		if(com !=null && com.trim().equals("signup")) {
			viewPage = "/WEB-INF/view/signup.jsp";
		}
		if(com !=null && com.trim().equals("insert")) {
			command = new MInsertCommand();
			command.execute(request, response);
			viewPage = "index.do";
		}
		if(com !=null && com.trim().equals("logout")) {
			HttpSession session = request.getSession();
			session.invalidate();
			viewPage = "index.do";
		}
		if(com !=null && com.trim().equals("login")) {
			command = new MLoginCommand();
			command.execute(request, response);
			viewPage = "index.do";
		}
		if(com !=null && com.trim().equals("mypage")) {
			viewPage = "/WEB-INF/view/mypage_myinfo.jsp";
		}

		
		
		
		
		if(com !=null && com.trim().equals("japBoard")) {
			command = new BListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/view/BoardJapan.jsp";
		}
		if(com !=null && com.trim().equals("korBoard")) {
			command = new BListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/view/BoardKorea.jsp";
		}
		if(com !=null && com.trim().equals("boardInsertForm")) {
			viewPage = "/WEB-INF/view/BoardInsertForm.jsp";
		}
		if(com !=null && com.trim().equals("boardInsert")) {
			command = new BInsertCommand();
			command.execute(request, response);
			viewPage = "index.do";
		}
		if(com !=null && com.trim().equals("boardView")) {
			command = new BViewCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/view/BoardViewForm.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);	
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {doHandler(request, response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {doHandler(request, response);}
}
