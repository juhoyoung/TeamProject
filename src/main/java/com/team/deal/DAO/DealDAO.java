package com.team.deal.DAO;

import java.util.List;
import java.util.Map;


import com.team.deal.DTO.DealDTO;


public interface DealDAO {
	//�Խù� ��Ϻ���
	public List<DealDTO> dealList() throws Exception;
	/*public List<DealDTO> getListWithPaging(Map<String, Object> map)throws Exception;*/
	public int totalCount()throws Exception;
	//�Խù� �ۼ�
	public void writerDeal(DealDTO ddto)throws Exception;
	// �Խù� �� ���� ��ȸ
	public DealDTO dealRead(int DEAL_NUM)throws Exception;
	
	// �Խù� �����ϱ�
	public void dealUpdate(DealDTO ddto) throws Exception;
		
	//����
	public void dealDelete(int DEAL_NUM) throws Exception;

		
		
}
