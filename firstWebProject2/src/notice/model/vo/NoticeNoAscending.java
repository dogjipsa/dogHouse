package notice.model.vo;

import java.util.*;

public class NoticeNoAscending implements Comparator{
		
	@Override
	public int compare(Object obj1, Object obj2) {
		Notice n1 = (Notice)obj1;
		Notice n2 = (Notice)obj2;
		
		int result = (n1.getNoticeNo() > n2.getNoticeNo())? 1 : (n1.getNoticeNo() == n2.getNoticeNo())? 0 : -1;
		return result; 
}
}
