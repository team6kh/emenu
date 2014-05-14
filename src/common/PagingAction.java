package common;

public class PagingAction {
	
    private String actionName; // 액션 이름...
    private int currentPage; // 현재페이지
    private int totalCount; // 전체 게시물 수
    private int totalPage; // 전체 페이지 수
    private int blockCount; // 한 페이지의 게시물의 수
    private int blockPage; // 한 화면에 보여줄 페이지 수
    private int startCount; // 한 페이지에서 보여줄 게시글의 시작 번호
    private int endCount; // 한 페이지에서 보여줄 게시글의 끝 번호
    private int startPage; // 시작 페이지
    private int endPage; // 마지막 페이지
    private String session_id; //세션
    private int rest_num; //글의 번호
    private int ccp; // 리뷰의 페이지 번호
    private StringBuffer pagingHtml;    

    // 생성자1: String actionName 파라미터 추가
    public PagingAction(String actionName, int currentPage, int totalCount, int blockCount, int blockPage) {
		
    	this.actionName = actionName;
		this.blockCount = blockCount;
		this.blockPage = blockPage;
		this.currentPage = currentPage;
		this.totalCount = totalCount;

		// 전체 페이지 수
		totalPage = (int) Math.ceil((double) totalCount / blockCount);
		if (totalPage == 0) {
			totalPage = 1;
		}

		// 현재 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}

		// 현재 페이지의 처음과 마지막 글의 번호 가져오기
		startCount = (currentPage - 1) * blockCount;
		endCount = startCount + blockCount - 1;

		// 시작 페이지와 마지막 페이지 값 구하기
		startPage = (int) ((currentPage - 1) / blockPage) * blockPage + 1;
		endPage = startPage + blockPage - 1;

		// 마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (endPage > totalPage) {
			endPage = totalPage;
		}

		// 이전 block 페이지
		pagingHtml = new StringBuffer();
		if (currentPage > blockPage) {
			pagingHtml.append("<li><a href=" + actionName
						+ ".do?currentPage=" + (startPage - 1) + ">");
			pagingHtml.append("이전");
			pagingHtml.append("</a></li>");
		}

		// 페이지 번호. 현재 페이지는 파란색으로 강조하고 링크를 제거
		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}
			if (i == currentPage) {
				pagingHtml.append("<li class='active'><a>");
				pagingHtml.append(i);
				pagingHtml.append("</a></li>");
			} else {
				pagingHtml.append("<li><a href=" + actionName
						+ ".do?currentPage=");
				pagingHtml.append(i);
				pagingHtml.append(">");
				pagingHtml.append(i);
				pagingHtml.append("</a><li>");
			}
		}

		// 다음 block 페이지
		if (totalPage - startPage >= blockPage) {
			pagingHtml.append("<li><a href=" + actionName
					+ ".do?currentPage=" + (endPage + 1) + ">");
			pagingHtml.append("다음");
			pagingHtml.append("</a></li>");
		}
	}
    // .생성자1
    
    
    // 생성자2: 구매내역 페이지
    public PagingAction(String actionName, int currentPage, int totalCount, int blockCount, int blockPage, String session_id) {
		
    	this.actionName = actionName;
		this.blockCount = blockCount;
		this.blockPage = blockPage;
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.session_id=session_id;

		// 전체 페이지 수
		totalPage = (int) Math.ceil((double) totalCount / blockCount);
		if (totalPage == 0) {
			totalPage = 1;
		}

		// 현재 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}

		// 현재 페이지의 처음과 마지막 글의 번호 가져오기
		startCount = (currentPage - 1) * blockCount;
		endCount = startCount + blockCount - 1;

		// 시작 페이지와 마지막 페이지 값 구하기
		startPage = (int) ((currentPage - 1) / blockPage) * blockPage + 1;
		endPage = startPage + blockPage - 1;

		// 마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (endPage > totalPage) {
			endPage = totalPage;
		}

		// 이전 block 페이지
		pagingHtml = new StringBuffer();
		if (currentPage > blockPage) {
			pagingHtml.append("<li><a href=" + actionName
					+ ".do?session_id="+session_id+"&currentPage=" + (startPage - 1) + ">");
			pagingHtml.append("이전");
			pagingHtml.append("</a></li>");
		}

		// 페이지 번호. 현재 페이지는 파란색으로 강조하고 링크를 제거
		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}
			if (i == currentPage) {
				pagingHtml.append("<li class='active'><a>");
				pagingHtml.append(i);
				pagingHtml.append("</a></li>");
			} else {
				pagingHtml.append("<li><a href=" + actionName
						+ ".do?session_id="+session_id+"&currentPage=");
				pagingHtml.append(i);
				pagingHtml.append(">");
				pagingHtml.append(i);
				pagingHtml.append("</a><li>");
			}
		}

		// 다음 block 페이지
		if (totalPage - startPage >= blockPage) {
			pagingHtml.append("<li><a href=" + actionName
					+ ".do?session_id="+session_id+"&currentPage=" + (endPage + 1) + ">");
			pagingHtml.append("다음");
			pagingHtml.append("</a></li>");
		}
	}
    // .생성자2    
    
    // 생성자3: 리뷰 페이지
    public PagingAction(String actionName, int ccp, int totalCount, int blockCount, int blockPage, int rest_num, int currentPage) {

		this.actionName = actionName;
		this.blockCount = blockCount;
		this.blockPage = blockPage;
		this.ccp = ccp;
		this.totalCount = totalCount;
		
		this.rest_num = rest_num;
		this.currentPage = currentPage;

		// 전체 페이지 수
		totalPage = (int) Math.ceil((double) totalCount / blockCount);
		if (totalPage == 0) {
			totalPage = 1;
		}

		// 현재 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (ccp > totalPage) {
			ccp = totalPage;
		}

		// 현재 페이지의 처음과 마지막 글의 번호 가져오기.
		startCount = (ccp - 1) * blockCount;
		endCount = startCount + blockCount - 1;

		// 시작 페이지와 마지막 페이지 값 구하기.
		startPage = (int) ((ccp - 1) / blockPage) * blockPage + 1;
		endPage = startPage + blockPage - 1;

		// 마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (endPage > totalPage) {
			endPage = totalPage;
		}

		// 이전 block 페이지
		pagingHtml = new StringBuffer();
		if (ccp > blockPage) {
		    
			pagingHtml.append("<li><a href=" + actionName + ".do?rest_num="+rest_num+"&currentPage="+currentPage+"&ccp="+ (startPage - 1) + ">");
			pagingHtml.append("이전");
			pagingHtml.append("</a></li>");
		}

		// 페이지 번호. 현재 페이지는 파란색으로 강조하고 링크를 제거.
		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}
			if (i == ccp) {
				pagingHtml.append("<li class='active'><a>");
				pagingHtml.append(i);
				pagingHtml.append("</a></li>");
			} else {
				pagingHtml.append("<li><a href=" + actionName + ".do?rest_num="+rest_num+"&currentPage="+currentPage+"&ccp=");
				pagingHtml.append(i);
				pagingHtml.append(">");
				pagingHtml.append(i);
				pagingHtml.append("</a><li>");
			}

		}

		// 다음 block 페이지
		if (totalPage - startPage >= blockPage) {
			pagingHtml.append("<li><a href=" + actionName + ".do?rest_num="+rest_num+"&currentPage="+currentPage+"&ccp="
					+ (endPage + 1) + ">");
			pagingHtml.append("다음");
			pagingHtml.append("</a></li>");
		}
	}
	// .생성자3    

    public String getActionName() {
        return actionName;
    }

    public void setActionName(String actionName) {
        this.actionName = actionName;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBlockCount() {
        return blockCount;
    }

    public void setBlockCount(int blockCount) {
        this.blockCount = blockCount;
    }

    public int getBlockPage() {
        return blockPage;
    }

    public void setBlockPage(int blockPage) {
        this.blockPage = blockPage;
    }

    public int getStartCount() {
        return startCount;
    }

    public void setStartCount(int startCount) {
        this.startCount = startCount;
    }

    public int getEndCount() {
        return endCount;
    }

    public void setEndCount(int endCount) {
        this.endCount = endCount;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public StringBuffer getPagingHtml() {
        return pagingHtml;
    }

    public void setPagingHtml(StringBuffer pagingHtml) {
        this.pagingHtml = pagingHtml;
    }

	public String getSession_id() {
		return session_id;
	}

	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}

	public int getRest_num() {
		return rest_num;
	}

	public void setRest_num(int rest_num) {
		this.rest_num = rest_num;
	}

	public int getCcp() {
		return ccp;
	}

	public void setCcp(int ccp) {
		this.ccp = ccp;
	}
    
}
