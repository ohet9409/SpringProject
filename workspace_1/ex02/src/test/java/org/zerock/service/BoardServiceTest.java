package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	/*
	 * @Test public void testExist() { log.info(service); assertNotNull(service); }
	 */
	/*@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("�����ۼ��ϴ±�");
		board.setContent("�����ۼ��ϴ³���");
		board.setWriter("newbie");
		
		service.register(board);
		log.info("������ �Խù��� ��ȣ: " + board.getBno());
	}
	
	@Test
	public void testGetList() {
		service.getList().forEach(board ->log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}*/
	@Test
	public void testDelete() {
		//�Խù� ��ȣ�� ���� ���θ� Ȯ���ϰ� �׽�Ʈ �� ��
		log.info("REMOVE RESULT : " + service.remove(2L));
	}
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		if (board == null) {
			return;
		}
		board.setTitle("���� �����մϴ�.");
		log.info("Modify result : " + service.modify(board));
	}
	
	public void testGetList() {
		service.getList(new Criteria(2,10)).forEach(board -> log.info(board));
	}

}