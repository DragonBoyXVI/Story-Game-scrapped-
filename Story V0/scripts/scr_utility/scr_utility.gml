
function fun_list_to_array(_list, _array = array_create(ds_list_size(_list))) {//convert a ds list to an array, keeps the list order
	
	var i = 0
	repeat(ds_list_size(_list)) {
		
		_array[i] = ds_list_find_value(_list, i)
		
		i++
		
	}
	
	return _array
	
}
