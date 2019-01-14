package com.team.deal.DTO;

public class BoardAttachVO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
	
	private Long bno;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public boolean isFileType() {
		return fileType;
	}

	public void setFileType(boolean fileType) {
		this.fileType = fileType;
	}

	public Long getBno() {
		return bno;
	}

	public void setBno(Long bno) {
		this.bno = bno;
	}

	public BoardAttachVO(String fileName, String uploadPath, String uuid, boolean fileType, Long bno) {
		super();
		this.fileName = fileName;
		this.uploadPath = uploadPath;
		this.uuid = uuid;
		this.fileType = fileType;
		this.bno = bno;
	}

	public BoardAttachVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "BoardAttachVO [fileName=" + fileName + ", uploadPath=" + uploadPath + ", uuid=" + uuid + ", fileType="
				+ fileType + ", bno=" + bno + "]";
	}
	
	
}
