package com.nellem.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nellem.datoBoard.BoardDAO;
import com.nellem.datoBoard.BoardDTO;
import com.nellem.datoBoardType.BoardTypeDAO;
import com.nellem.datoBoardType.BoardTypeDTO;
import com.nellem.datoMember.MemberDAO;
import com.nellem.datoMember.MemberDTO;

public class BListCommand implements InterfaceCommand {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDTO dtoBoard = new BoardDTO();
		BoardDAO daoBoard = new BoardDAO();
		BoardTypeDTO dtoBoardType = new BoardTypeDTO();
		BoardTypeDAO daoBoardType = new BoardTypeDAO();
		
		int boardType = Integer.parseInt(request.getParameter("boardNo"));		
		List<BoardTypeDTO> dtosBoardType = daoBoardType.boardTypeList();
		List<BoardDTO> dtosBoard = daoBoard.boardListInnerJoin(boardType);
		
		// 게시글 내의 유튜브 링크 추출
		String codeUrl = null;
		String content = null;
		for(BoardDTO dto : dtosBoard) {
			content = dto.getContent();
			if(content.contains("https://www.youtube.com/embed/")) {
				//<p><iframe allowfullscreen="" frameborder="0" height="360" src="https://www.youtube.com/embed/kS3FFlFOQMo?rel=0" width="640"></iframe></p>
				//<a href="https://www.youtube.com/embed/am8mLH41iDU?rel=0"><img src="https://img.youtube.com/vi/am8mLH41iDU/sddefault.jpg" style="height:360px; width:640px" /></a></p>
				codeUrl= dto.getContent().substring(dto.getContent().indexOf("=\"https://www.youtube.com/embed/") + 32, dto.getContent().indexOf("=\"https://www.youtube.com/embed/") + 43); //command :insert
			} else {
				// 유튜브주소 없음
				codeUrl = "SdcS0avMrXQ";
			}
			dto.setYoutubeCode(codeUrl);
		}
		
		request.setAttribute("dtos_board", dtosBoard);
		request.setAttribute("dtos_boardType", dtosBoardType);
	}
}