package kr.ezen.guest.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import kr.ezen.guest.dao.GuestBookDAO;
import kr.ezen.guest.vo.GuestBookVO;
import kr.ezen.jdbc.JdbcUtil;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class GuestBookService {
	// I. singleton
	private static GuestBookService instance = new GuestBookService();

	private GuestBookService() {;}

	public static GuestBookService getInstance() {
		return instance;
	}

	// II. METHOD

	// 1. all
	public List<GuestBookVO> selectList(){
		log.debug("selectList 호출 ");
		List<GuestBookVO> list = null;
		Connection conn = null;
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);
			
			list = GuestBookDAO.getInstance().selectList(conn);
			
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}
		log.debug("selectList 리턴 {}",list);
		return list;
	}
	
	// 2. insert
	public int insert(GuestBookVO vo){
		int count = 0;
		log.debug("insert 호출 {}",vo);
		Connection conn = null;
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);
			
			count = GuestBookDAO.getInstance().insert(conn,vo);
			
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}
		log.debug("insert 리턴 {}",count);
		return count;
	}
	// 3. update
	public int update(GuestBookVO vo){
		int count = 0;
		log.debug("update 호출 {}",vo);
		Connection conn = null;
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);
			if(vo!=null) {
				GuestBookVO dbvo = GuestBookDAO.getInstance().selectByIdx(conn, vo.getIdx());
				if(dbvo!=null && dbvo.getPassword().equals(vo.getPassword())) {
					count = GuestBookDAO.getInstance().update(conn,vo);					
				}
			}
			
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}
		log.debug("update 리턴 {}",count);
		return count;
	}
	// 4. delete
	public int delete(GuestBookVO vo){
		int count = 0;
		log.debug("delete 호출 {}",vo);
		Connection conn = null;
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);
			if(vo!=null) {
				GuestBookVO dbvo = GuestBookDAO.getInstance().selectByIdx(conn, vo.getIdx());
				if(dbvo!=null && dbvo.getPassword().equals(vo.getPassword())) {
					count = GuestBookDAO.getInstance().delete(conn,vo.getIdx());					
				}
			}
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}
		log.debug("delete 리턴 {}",count);
		return count;
	}
	
	// 5. one
	public GuestBookVO selectByIdx(int idx) {
		log.debug("selectByIdx 호출 {}",idx);
		GuestBookVO vo = null;
		Connection conn = null;
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);
			
			vo = GuestBookDAO.getInstance().selectByIdx(conn,idx);
			
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}
		log.debug("selectByIdx 리턴 {}",vo);
		return vo;
	}
	
	// 6. 조회수 증가시켜주는
	public int updateVcount(GuestBookVO vo){
		int count = 0;
		log.debug("updateVcount 호출 {}",vo);
		Connection conn = null;
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);
			
			count = GuestBookDAO.getInstance().updateVcount(conn,vo);
			
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}
		log.debug("updateVcount 리턴 {}",count);
		return count;
	}
}
