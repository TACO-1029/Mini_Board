package kr.or.kosa.dto;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {  //SELECT * FROM jspboard

  private int idx;  //jspboard 컬럼명과 동일
  private String writer;
  private String pwd;
  private String subject;
  private String content;
  //not null (필수 입력)
  private Date writedate; //default SYSDATE
  private int readnum;    //default 0

  private String filename;
  private int filesize;
  private String homepage;
  private String email;
  //부가 입력 사항

  //계층형 (답글)
  private int refer;//글의 묶음
  private int depth;//글의 들여쓰기
  private int step;//글의 순서

}










