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
public class Reply {

  private int no;
  private String writer;
  private String userid;
  private String pwd;
  private String content;
  private Date writedate;
  private int idx_fk;

}
