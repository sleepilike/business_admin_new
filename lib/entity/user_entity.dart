class UserEntity {
	int id;
	int gender;
	String  username;
	String name;
	String phoneNum;
	String wechatAccount;
	String wechatId;
	String regTime;
	String indentityId;
	String job;
	int firstPositionId;
	int secondPositionId;
	int firstDepId;
	int secondDepId;
	int roleId;
	String wokeCurAdd;
	int status;
	String firstDepName;
	String secondDepName;
	String firstPosition;
	String secondPosition;

	UserEntity(
			{this.id,
				this.gender,
				this.username,
				this.name,
				this.phoneNum,
				this.wechatAccount,
				this.wechatId,
				this.regTime,
				this.indentityId,
				this.job,
				this.firstPositionId,
				this.secondPositionId,
				this.firstDepId,
				this.secondDepId,
				this.roleId,
				this.wokeCurAdd,
				this.status,
				this.firstDepName,
				this.secondDepName,
				this.firstPosition,
				this.secondPosition});

	UserEntity.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		gender = json['gender'];
		username = json['username'];
		name = json['name'];
		phoneNum = json['phoneNum'];
		wechatAccount = json['wechatAccount'];
		wechatId = json['wechatId'];
		regTime = json['regTime'];
		indentityId = json['indentityId'];
		job = json['job'];
		firstPositionId = json['firstPositionId'];
		secondPositionId = json['secondPositionId'];
		firstDepId = json['firstDepId'];
		secondDepId = json['secondDepId'];
		roleId = json['roleId'];
		wokeCurAdd = json['wokeCurAdd'];
		status = json['status'];
		firstDepName = json['firstDepName'];
		secondDepName = json['secondDepName'];
		firstPosition = json['firstPosition'];
		secondPosition = json['secondPosition'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['gender'] = this.gender;
		data['username'] = this.username;
		data['name'] = this.name;
		data['phoneNum'] = this.phoneNum;
		data['wechatAccount'] = this.wechatAccount;
		data['wechatId'] = this.wechatId;
		data['regTime'] = this.regTime;
		data['indentityId'] = this.indentityId;
		data['job'] = this.job;
		data['firstPositionId'] = this.firstPositionId;
		data['secondPositionId'] = this.secondPositionId;
		data['firstDepId'] = this.firstDepId;
		data['secondDepId'] = this.secondDepId;
		data['roleId'] = this.roleId;
		data['wokeCurAdd'] = this.wokeCurAdd;
		data['status'] = this.status;
		data['firstDepName'] = this.firstDepName;
		data['secondDepName'] = this.secondDepName;
		data['firstPosition'] = this.firstPosition;
		data['secondPosition'] = this.secondPosition;
		return data;
	}
}