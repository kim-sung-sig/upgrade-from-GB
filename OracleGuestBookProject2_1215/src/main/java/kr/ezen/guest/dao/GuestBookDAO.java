package kr.ezen.guest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ezen.guest.vo.GuestBookVO;
import kr.ezen.jdbc.JdbcUtil;

public class GuestBookDAO {
	// I. Singleton?
	private static GuestBookDAO instance = new GuestBookDAO();

	private GuestBookDAO() {;}

	public static GuestBookDAO getInstance() {
		return instance;
	}
	// end - singleton

	// II. METHOD
	// 1. all
	public List<GuestBookVO> selectList(Connection conn) throws SQLException {
		List<GuestBookVO> list = null;
		String sql = "select * from myguestbook order by idx DESC";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			list = new ArrayList<>();
			do {
				GuestBookVO vo = new GuestBookVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setName(rs.getString("name"));
				vo.setPassword(rs.getString("password"));
				vo.setContent(rs.getString("content"));
				vo.setRegdate(rs.getTimestamp("regdate"));
				vo.setVcount(rs.getInt("vcount"));
				vo.setIp(rs.getString("ip"));

				list.add(vo);
			} while (rs.next());
		}
		JdbcUtil.close(rs);
		JdbcUtil.close(stmt);
		return list;
	}

	// 2. insert
	public int insert(Connection conn, GuestBookVO vo) throws SQLException {
		int count = 0;
		String sql = "insert into myguestbook values(guest2_idx_seq.nextval,?,?,?,?,sysdate,0,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vo.getTitle());
		pstmt.setString(2, vo.getName());
		pstmt.setString(3, vo.getPassword());
		pstmt.setString(4, vo.getContent());
		pstmt.setString(5, vo.getIp());
		count = pstmt.executeUpdate();
		JdbcUtil.close(pstmt);
		return count;
	}

	// 3. update
	public int update(Connection conn, GuestBookVO vo) throws SQLException {
		int count = 0;
		String sql = "update myguestbook set title = ?, content = ?, regdate = sysdate, vcount = 0,ip = ? where idx=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vo.getTitle());
		pstmt.setString(2, vo.getContent());
		pstmt.setString(3, vo.getIp());
		pstmt.setInt(4, vo.getIdx());
		count = pstmt.executeUpdate();
		JdbcUtil.close(pstmt);
		return count;
	}

	// 4. delete
	public int delete(Connection conn, int idx) throws SQLException {
		int count = 0;
		String sql = "delete from myguestbook where idx=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, idx);
		count = pstmt.executeUpdate();
		JdbcUtil.close(pstmt);
		return count;
	}

	// 5. one
	public GuestBookVO selectByIdx(Connection conn, int idx) throws SQLException {
		GuestBookVO vo = null;
		String sql = "select * from myguestbook where idx=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, idx);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			vo = new GuestBookVO();
			vo.setIdx(rs.getInt("idx"));
			vo.setTitle(rs.getString("title"));
			vo.setName(rs.getString("name"));
			vo.setPassword(rs.getString("password"));
			vo.setContent(rs.getString("content"));
			vo.setRegdate(rs.getTimestamp("regdate"));
			vo.setVcount(rs.getInt("vcount"));
			vo.setIp(rs.getString("ip"));
		}
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
		return vo;
	}
	
	// 6. 조회수 증가시켜주는 메서드
	public int updateVcount(Connection conn, GuestBookVO vo) throws SQLException {
		int count = 0;
		String sql = "update myguestbook set vcount = ? where idx=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, vo.getVcount()+1);
		pstmt.setInt(2, vo.getIdx());
		count = pstmt.executeUpdate();
		JdbcUtil.close(pstmt);
		return count;
	}
}
