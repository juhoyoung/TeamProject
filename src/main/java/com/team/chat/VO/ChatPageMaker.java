package com.team.chat.VO;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class ChatPageMaker {
	
	private ChatCriteria cri; //page, perPageNum
	private Integer totalCount; //총 게시물 수
	
	private Integer startPage; //시작 페이지
	private Integer endPage; //끝 페이지
	private boolean prev; //이전
	private boolean next; //이후
	
	private Integer displayPageNum = 10;
	
	public String makeSearch(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
									  .queryParam("page", page)
									  .queryParam("perPageNum", cri.getPerPageNum())
									  .queryParam("searchType", ((ChatSearchVO)cri).getSearchKey())
									  .queryParam("keyword", ((ChatSearchVO)cri).getSearchValue())
									  .build();
		return uriComponents.toUriString();
	}
	//검색 키워드의 인코딩 처리를 위한 메서드
	private String encoding(String keyword) {
		if (keyword == null || keyword.trim().length() == 0) {
			return "";
		}
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}
	}
	public String makeQuery(Integer page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
									  .queryParam("page", page)
									  .queryParam("perPageNum", cri.getPerPageNum())
									  .build();
		return uriComponents.toUriString();
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	private void calcData() {
		endPage = (int)Math.ceil((double)cri.getPage()/displayPageNum)*displayPageNum;
		startPage = (endPage - displayPageNum) + 1;
		int tempEndPage = (int)Math.ceil((double)totalCount/displayPageNum);
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = (startPage == 1? false:true);
		next = (tempEndPage > endPage? true:false);
	}
	//getter, setter 메서드
	public ChatCriteria getCri() {
		return cri;
	}
	public void setCri(ChatCriteria cri) {
		this.cri = cri;
	}
	public Integer getStartPage() {
		return startPage;
	}
	public void setStartPage(Integer startPage) {
		this.startPage = startPage;
	}
	public Integer getEndPage() {
		return endPage;
	}
	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public Integer getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(Integer displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
}
