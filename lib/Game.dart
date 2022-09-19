import 'dart:math';

class Game {
  var ans;
    Game(){
      var r = Random();
      ans = r.nextInt(100)+1;
    }
    int check(int num){
        if(num==ans){
          return 0;
        }else if(num>ans){
          return 1;
        }else{
          return-1;
        }
    }


}
