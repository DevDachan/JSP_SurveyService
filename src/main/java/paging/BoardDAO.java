package paging;

import java.util.ArrayList;

import javax.servlet.ServletContext;

import util.DatabaseUtil;

public class BoardDAO extends DatabaseUtil {
	
	
	
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	public int getNext() {
		String SQL = "SE"
	}

	public ArrayList<BoardDTO> getList(int pageNumber) {
		//조회된 기준 boardID로 내림차순하여 위에 10개만 보여주는 쿼리
		String SQL = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10";
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, getNext() - (pageNumber-1)*10);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				BoardDAO board = new BoardDAO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}
	
	//게시글 수에 따라 페이징 처리하기 위함.
	public boolean nextPage(int pageNumber) {
		//조회된 기준 boardID로 내림차순하여 위에 10개만 보여주는 쿼리
		String SQL = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - ((pageNumber-1) * 10));
			rs = pstmt.executeQuery();
			
			//다음 버튼을 보여줄지 판단하는 부분
			while(rs.next()) {	
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}