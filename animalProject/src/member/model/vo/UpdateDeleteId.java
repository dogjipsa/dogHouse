package member.model.vo;

import java.util.UUID;

public class UpdateDeleteId implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8370993066824455302L;
	
	private UUID uuid = UUID.randomUUID();
	
	public UpdateDeleteId() {}
	
	public UpdateDeleteId(UUID uuid) {
		this.uuid = uuid;
	}

	public UUID getUuid() {
		return uuid;
	}

	public void setUuid(UUID uuid) {
		this.uuid = uuid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String toString() {
		
		for(int i=0; i < 10; i++) {
			uuid = UUID.randomUUID();
		}
		//randomId = uuid.toString();
		System.out.println("삭제 후 변경 아이디 : " + uuid.toString());
		String deleteId = "del" + uuid.toString().substring(5,10);
		
		System.out.println("삭제 후 변경 아이디 : " + deleteId);
		
		return deleteId;
	}
	
}
