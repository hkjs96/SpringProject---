package kr.or.anyapart.board.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup2;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.BaseVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="boNo",callSuper=true)
@ToString(exclude= {"boContent", "boFiles", "attachList", "replyList"})
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIgnoreProperties("boFiles")
public class BoardVO extends BaseVO{
	@NotNull (groups = {UpdateGroup.class,DeleteGroup.class})
	private Integer boNo; //게시글 번호
	
	@Size(max=15) 
	@NotBlank (groups = {InsertGroup2.class}, message="분류를 선택하세요.")
	private String boType; //게시판 분류 코드
	
	@NotBlank
	@Size(max=200) 
	private String boTitle; //글 제목
	
	@NotBlank 
	@Size(max=15) 
	private String boWriter; //사용자 코드 -> 입주민자유게시판에서 mem_nick으로 치환해서 데려옴
	
	private String boWriterId; // 삭제시 mem_id와 작성자id 비교하기위함
	
	@NotBlank(groups = {UpdateGroup.class})
	@Size(max=4000) 
	private String boContent; //내용
	
	private String boDate; //작성일 
	
	private Integer boHit; //조회수
	
	private Integer boParent; //부모글
	
	private Integer boDepth; //계층 레벨
	
	private transient List<MultipartFile> boFiles;
	
	public void setBoFiles(List<MultipartFile> boFiles) {
		if(boFiles==null || boFiles.size()==0) return;
		this.boFiles = boFiles;
		this.attachList = new ArrayList<>();
		for(MultipartFile tmp : boFiles) {
			if(StringUtils.isBlank(tmp.getOriginalFilename())) continue;
			attachList.add(new AttachVO(tmp));
		}
	}
	private transient List<AttachVO> attachList;
	private transient List<ReplyVO> replyList;
	private int startAttNo;
	private int[] delAttNos; // 파일지울때
		
	@Size(max=3) 
	private String boDelete; //삭제여부
	
	private Integer rnum; // rnum
	private Integer repCnt; // 댓글카운트
	
	/**
	 * @author 박지수 
	 * @since 2021 02 09
	 * 답변 확인용 플래그 
	 */
	private Integer answerFlag; // 답변 확인용 플래그
	
	private String aptName;	// 벤더사이트 문의 아파트 이름 확인용
	private String unAnswered;	// 미답변 문의글 플래그 
	
	private Integer allNum; // 전체 글의 수
	private Integer unAnsNum; // 미 답변 글수
	private Integer ansNum;	// 답변 수
	
	private String aptCode;	// 아파트 코드
}
