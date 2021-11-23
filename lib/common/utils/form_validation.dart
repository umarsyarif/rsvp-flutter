class FormValidation{
  FormValidation._();
  static String? validate(String value,{String? label}){
    if(value.isEmpty){
      return "$label harus diisi";
    }
    return null;
  }
  static String? validatePassword(String? value){
    if((value?.length??0)<6){
      return 'Password minimal 6 karakter';
    }
    return null;
  }
  static String? validateEmail(String? value){
    if(value!=null){
      bool isValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
      if(isValid){
        return null;
      }else{
       return 'Email tidak valid';
      }
    }else{
      return 'Email wajib diisi';
    }

  }
  static String? validateNik(String value,{String? label}){
    if(value.isEmpty){
      return "$label harus diisi";
    }else if(value.length<16){
      return "$label harus 16 karakter";
    }
    return null;
  }
  static String? validateNoHp(String value){
    if(value.isEmpty){
      return 'No HP tidak boleh kosong';
    }
    else if(value.length<11){
      return 'No HP tidak valid';
    }
    else if(value.substring(0,2)!='08'&&value.substring(0,3)!='+62'&&value.substring(0,2)!='62'){
      return 'No HP tidak valid';
    }
    return null;
  }
}
