package com.team.message.VO;

//쪽지 검색을 위한 메서드
public class MessageSearchVO extends Criteria{
	private String searchKey;
	private String searchValue;
	
	//getter, setter 메서드
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

}
