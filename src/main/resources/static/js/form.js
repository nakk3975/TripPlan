function valueCheck(value, alertString){
	if(value.val() == ""){
		alert(alertString + "을(를) 입력하세요.");
		value.focus();
		return false;
	}
	return true;
}