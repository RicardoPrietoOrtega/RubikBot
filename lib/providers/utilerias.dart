import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:provider/provider.dart';

List<int> secuencia=[0,0,0,0,0,0];

List<List<int>> indices = [
  [   // Frente 1
    0, 1,45, 3, 4,46, 6, 7,47,
    15,12, 9,16,13,10,17,14,11,
    42,19,20,43,22,23,44,25,26,
    27,28,29,30,31,32,33,34,35,
    36,37,38,39,40,41,8 ,5 , 2,
    24,21,18,48,49,50,51,52,53
  ],
  [  // Frente inverso 2
    0, 1,44, 3, 4,43, 6, 7,42,
    11,14,17,10,13,16, 9,12,15,
    47,19,20,46,22,23,45,25,26,
    27,28,29,30,31,32,33,34,35,
    36,37,38,39,40,41,18,21,24,
    2, 5, 8,48,49,50,51,52,53
  ],
  [ // Frente completo 3
    51,48,45,52,49,46,53,50,47,
    15,12, 9,16,13,10,17,14,11,
    42,39,36,43,40,37,44,41,38,
    29,32,35,28,31,34,27,30,33,
    6, 3, 0, 7, 4, 1, 8, 5, 2,
    24,21,18,25,22,19,26,23,20,
  ],
  [ // Frente inverso completo 4
    38,41,44,37,40,43,36,39,42,
    11,14,17,10,13,16, 9,12,15,
    47,50,53,46,49,52,45,48,51,
    33,30,27,34,31,28,35,32,29,
    20,23,26,19,22,25,18,21,24,
    2, 5, 8, 1, 4, 7, 0, 3, 6
  ],
  [   // Derecha 5
      0, 1, 2, 3, 4, 5, 6, 7, 8,
      9,10,47,12,13,50,15,16,53,
    24,21,18,25,22,19,26,23,20,
    44,28,29,41,31,32,38,34,35,
    36,37,11,39,40,14,42,43,17,
    45,46,33,48,49,30,51,52,27
  ],
  [   // Derecha inverso 6
      0, 1, 2, 3, 4, 5, 6, 7, 8,
      9,10,38,12,13,41,15,16,44,
    20,23,26,19,22,25,18,21,24,
    53,28,29,50,31,32,47,34,35,
    36,37,33,39,40,30,42,43,27,
    45,46,11,48,49,14,51,52,17
  ],
  [   // Derecha completo 7
      2, 5, 8, 1, 4, 7, 0, 3, 6,
    45,46,47,48,49,50,51,52,53,
    24,21,18,25,22,19,26,23,20,
    44,43,42,41,40,39,38,37,36,
      9,10,11,12,13,14,15,16,17,
    35,34,33,32,31,30,29,28,27
  ],
  [   // Derecha inverso completo 8
      6, 3, 0, 7, 4, 1, 8, 5, 2,
    36,37,38,39,40,41,42,43,44,
    20,23,26,19,22,25,18,21,24,
    53,52,51,50,49,48,47,46,45,
    35,34,33,32,31,30,29,28,27,
    9,10,11,12,13,14,15,16,17,
  ]
];

bool igualar(BuildContext context,  a, int b){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  return cubo[a] == cubo[b];
}

void libera1(BuildContext context){
  while(igualar(context, 13, 14)){
    mover(context, 1);
  }
}

void mover(BuildContext context, int ind) async {
  int i;
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  List<int> cubo2 = List.from(cubo); 
  if (ind > 0) {
    for (i = 0; i < 54; i++) {
      cubo2[i] = cubo[i]; 
    }
    for (i = 0; i < 54; i++) {
      cubo[i] = cubo2[indices[ind - 1][i]];
    }
    myProvider.cubo = cubo; 
  }
  await Future.delayed(const Duration(milliseconds: 500));
}

void cruz1(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int ref = cubo[13];
  while(cubo[10]!=ref || cubo[12]!=ref || cubo[14]!=ref || cubo[16]!=ref){
    if(cubo[41]==ref){
      libera1(context);
      mover(context, 6);
    } else if (cubo[50]==ref){
      libera1(context);
      mover(context, 5);
    } else if (cubo[30]==ref){
      libera1(context);
      mover(context, 5);
      mover(context, 5);
    } else if(cubo[21]==ref){
      libera1(context);
      mover(context, 5);
      mover(context, 2);
    } else if(cubo[23]==ref){
      libera1(context);
      mover(context, 6);
      mover(context, 3);
    } else {
      mover(context, 3);
    }
  }
}

void ordenarCruz1(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  while(cubo[43]!=cubo[40]){
    mover(context, 1);
  }

  if(igualar(context, 21,22)){
    if(igualar(context, 46, 49)){
      return;
    } else {
      mover(context, 2);
      mover(context, 5);
      mover(context, 2);
      mover(context, 6);
      mover(context, 1);
      mover(context, 5);
      mover(context, 1);
    }
  } else if(igualar(context, 21, 4)){
    if(igualar(context, 5,22)){
      mover(context, 5);
      mover(context, 1);
      mover(context, 1);
      mover(context, 6);
      mover(context, 1);
      mover(context, 1);
      mover(context, 5);
    } else {
      mover(context, 5);
      mover(context, 1);
      mover(context, 1);
      mover(context, 6);
      mover(context, 1);
      mover(context, 5);
      mover(context, 1);
      mover(context, 6);
    }
  } else if(igualar(context, 21,49)){
    if(igualar(context, 4,5)){
      mover(context, 5);
      mover(context, 2);
      mover(context, 6);
      mover(context, 1);
      mover(context, 5);
    } else {
      mover(context, 5);
      mover(context, 2);
      mover(context, 6);
      mover(context, 2);
      mover(context, 5);
      mover(context, 1);
      mover(context, 1);
      mover(context, 6);
    }
  }
}


void esquinas1(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int ref1;    

  mover(context, 8);
  mover(context, 3);  
  while(!igualar(context, 0, 4) || !igualar(context, 2, 4) || !igualar(context, 6, 4) || !igualar(context, 8, 4) || !igualar(context, 36, 39) || !igualar(context, 9, 12) || !igualar(context, 45, 48) || !igualar(context, 35, 32)){
    if(igualar(context, 11, 4)){
      ref1 = cubo[44];
      while(cubo[13]!=ref1){
        mover(context, 8);
      }
      while(cubo[53]!=ref1){
        mover(context, 5);
      }
      mover(context, 2);
      mover(context, 5);
      mover(context, 1);
    } else if (igualar(context, 44, 4)){
      ref1 = cubo[11];
      while(cubo[13]!=ref1){
        mover(context, 8);
      }
      while(cubo[38]!=ref1){
        mover(context, 5);
      }
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
    } else if (igualar(context, 18, 4)){
      ref1 = cubo[44];
      while(cubo[13]!=ref1){
        mover(context, 8);
      }
      while(cubo[44]!=ref1){
        mover(context, 5);
      }
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
      mover(context, 2);
      mover(context, 5);
      mover(context, 5);
      mover(context, 1);
    } else if(igualar(context, 42, 4)){
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
    } else if(igualar(context, 9, 4)){
      mover(context, 1);
      mover(context, 6);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
    } else if (igualar(context, 2, 4) && !igualar(context, 39, 42)){
      mover(context, 1);
      mover(context, 5);
      mover(context, 2);
      mover(context, 8);
    }
    else {
      mover(context, 8);
    }
  }
}

int indSecuancia(BuildContext context,  i1, int i2){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int i;
  for(i=1; i<5; i++){
    if(secuencia[i]==cubo[i1]){
      if(secuencia[i-1]==cubo[i2]){
        return 1;
      } else if(secuencia[i+1]==cubo[i2]){
        return 2;
      } else {
        return 0;
      }
    }
  }
  return 0;
}

void aristas2(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int ref;
  secuencia[0] = cubo[13];    // Verde
  secuencia[1] = cubo[40];    // Rojo
  secuencia[2] = cubo[31];    // Azul
  secuencia[3] = cubo[49];    // Naranja
  secuencia[4] = cubo[13];    // Verde
  secuencia[5] = cubo[40];    // Rojo
  //tpo = 9000;
  while(!igualar(context, 40,43) || !igualar(context, 10,13) || !igualar(context, 13,16) || !igualar(context, 46,49) || !igualar(context, 49,52) || !igualar(context, 34,31) || !igualar(context, 31,28) || !igualar(context, 37,40)) {
    if(indSecuancia(context, 41, 19)==1){
      ref = cubo[19];
      while(cubo[13]!=ref) {
        mover(context, 8);
      }
      while(cubo[30]!=cubo[40] || cubo[23]!=cubo[13]) {
        mover(context, 5);
      }
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
      mover(context, 6);
      mover(context, 2);
      mover(context, 5);
      mover(context, 1);
    } else if(indSecuancia(context, 41, 19)==2){
      ref = cubo[19];
      while(cubo[13]!=ref) {
        mover(context, 8);
      }
      while(cubo[30]!=cubo[49] || cubo[23]!=cubo[13]) {
        mover(context, 5);
      }
      mover(context, 2);
      mover(context, 5);
      mover(context, 1);
      mover(context, 7);
      mover(context, 5);
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
    } else if(indSecuancia(context, 43, 10)!=0 && !igualar(context, 43, 40)){
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
      mover(context, 6);
      mover(context, 2);
      mover(context, 5);
      mover(context, 1);
    }
    mover(context, 8);
  }
}

void cruzCapa3(BuildContext context){
  //var myProvider = Provider.of<MyProvider>(context, listen: false);
  //List<int> cubo = myProvider.cubo;
  int n = 0, i;
  List<int> aristas = [19, 21, 23, 25];
  for(i=0; i<4; i++){
    if(igualar(context, 22, aristas[i])){
      n++;
    }
  }
  if(n==4) {
    return;
  }
  if(n==0) {
    mover(context, 1);
    mover(context, 7);
    mover(context, 5);
    mover(context, 1);
    mover(context, 6);
    mover(context, 2);
    mover(context, 8);
    mover(context, 2);

    mover(context, 5);

    mover(context, 2);
    mover(context, 8);
    mover(context, 2);
    mover(context, 6);
    mover(context, 1);
    mover(context, 5);
    mover(context, 7);
    mover(context, 1);
  } else {
    while(!igualar(context, 19,22)){
      mover(context, 5);
    }
    if(igualar(context, 21,22)){
      mover(context, 5);
      mover(context, 1);
      mover(context, 7);
      mover(context, 5);
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
      mover(context, 2);
    } else if(igualar(context, 23,22)){
      mover(context, 1);
      mover(context, 7);
      mover(context, 5);
      mover(context, 1);
      mover(context, 6);
      mover(context, 2);
      mover(context, 8);
      mover(context, 2);
    } else {
      mover(context, 2);
      mover(context, 8);
      mover(context, 2);
      mover(context, 6);
      mover(context, 1);
      mover(context, 5);
      mover(context, 7);
      mover(context, 1);
    }
  }
}

int emparejar(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int i,j,r1, r2, r3;
  List<int> ref_ = [0,0,0,0,0,0];
  ref_[0] = cubo[14];
  ref_[1] = cubo[41];
  ref_[2] = cubo[30];
  ref_[3] = cubo[50];
  //ref_[4] = cubo[14];
  for(i=0;i<4;i++){
    r1 = ref_[i];
    r2 = ref_[i+1];
    r3 = ref_[i+2];      
    for(j=0;j<4;j++){
      if(r1==secuencia[j]){
        if(r2==secuencia[j+1]){
          if(r3==secuencia[j+2]){
            return 6;
          } else {
            return r1;
          }
        } else {
          break;
        }
      }
    }
  }
  return -1;
}

int ordenarCruz3(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int r = emparejar(context);
  if(r==6){
    while(cubo[14]!=cubo[13]){
      mover(context, 5);
    }
    return 0;
  }
  if(r>=0){
    while(cubo[13]!=r){
        mover(context, 7);
    }
    while(cubo[14]!=r){
        mover(context, 5);
    }
    mover(context, 5);
    mover(context, 2);
    mover(context, 5);
    mover(context, 5);
    mover(context, 1);
    mover(context, 5);
    mover(context, 2);
    mover(context, 5);
    mover(context, 1);
  } else {
    while(!igualar(context, 40, 41)){
      mover(context, 5);
    }
    mover(context, 5);
    mover(context, 2);
    mover(context, 5);
    mover(context, 5);
    mover(context, 1);
    mover(context, 5);
    mover(context, 2);
    mover(context, 5);
    mover(context, 1);    
    ordenarCruz3(context);
  }
  return 0;
}

bool revisarEsquina(BuildContext context, int a, int b, int c, int r1, int r2, int r3){
  return(
    ( igualar(context, a,r1) || igualar(context, a,r2) || igualar(context, a,r3) ) &&
    ( igualar(context, b,r1) || igualar(context, b,r2) || igualar(context, b,r3) ) &&
    ( igualar(context, c,r1) || igualar(context, c,r2) || igualar(context, c,r3) )
  );
}

void esquinas3(BuildContext context){
  bool continuar = true;
  int op=0;    
  while(continuar){        
    if(revisarEsquina(context, 26, 33, 53, 22, 31, 49) || op>3){
      continuar = false;
    } else {
      mover(context, 7);
    }
    op++;
  }
  if( op>3 ){
    mover(context, 2);
    mover(context, 5);
    mover(context, 7);
    mover(context, 7);
    mover(context, 1);
    mover(context, 6);
    mover(context, 8);
    mover(context, 8);
    mover(context, 1);
    mover(context, 5);
    mover(context, 7);
    mover(context, 7);
    mover(context, 2);
    mover(context, 6);
    continuar = true;
    while(continuar){
      if(revisarEsquina(context, 26, 33, 53, 22, 31, 49)){
        continuar = false;
      } else {
          mover(context, 7);
      }
    }
  }
  if(revisarEsquina(context, 17, 24, 47, 13, 22, 40)){
    mover(context, 2);
    mover(context, 5);
    mover(context, 7);
    mover(context, 7);
    mover(context, 1);
    mover(context, 6);
    mover(context, 8);
    mover(context, 8);
    mover(context, 1);
    mover(context, 5);
    mover(context, 7);
    mover(context, 7);
    mover(context, 2);
    mover(context, 6);
  } else if(revisarEsquina(context, 17, 24, 47, 31, 22, 40)){
    mover(context, 8);
    mover(context, 1);
    mover(context, 6);
    mover(context, 7);
    mover(context, 7);
    mover(context, 2);
    mover(context, 5);
    mover(context, 7);
    mover(context, 7);
    mover(context, 2);
    mover(context, 6);
    mover(context, 7);
    mover(context, 7);
    mover(context, 1);
    mover(context, 5);
  }
}


void basico(BuildContext context){
    mover(context, 5);
    mover(context, 2);
    mover(context, 6);
    mover(context, 1);
    mover(context, 5);
    mover(context, 2);
    mover(context, 6);
    mover(context, 7);
    mover(context, 7);
    mover(context, 1);
    mover(context, 8);
    mover(context, 8);
    mover(context, 5);
    mover(context, 1);
    mover(context, 6);
    mover(context, 2);
    mover(context, 5);
    mover(context, 1);
    mover(context, 6);
    mover(context, 7);
    mover(context, 7);
    mover(context, 2);
}


bool revisa4(BuildContext context, int r, int a, int b, int c, int d){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  return r==cubo[a] && r==cubo[b] && r==cubo[c] && r==cubo[d];
}

bool revisa3(BuildContext context, int r, int a, int b, int c){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  return r==cubo[a] && r==cubo[b] && r==cubo[c];
}

bool revisa2(BuildContext context, int r, int a, int b){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  return r==cubo[a] && r==cubo[b];
}

void orientarEsquinas(BuildContext context){
  var myProvider = Provider.of<MyProvider>(context, listen: false);
  List<int> cubo = myProvider.cubo;
  int buscar;
  bool salir;    
  mover(context, 4);
  mover(context, 8);
  buscar = cubo[13];
  salir=false;
  while (!salir) {
    //alg=false;
    if(revisa4(context, buscar, 9, 11, 15, 17)){
      salir = true;
    } else if(revisa2(context, buscar, 42, 44)){
      mover(context, 8);
    } else if(revisa2(context, cubo[49], 15, 17)){
      mover(context, 8);
      basico(context);      
    } else if(revisa3(context, buscar, 42, 18, 47)){        
      mover(context, 8);
      mover(context, 8);
      basico(context);        
    } else if(cubo[44]==buscar && (cubo[8]==buscar || cubo[45]==buscar) ){
      mover(context, 8);
      mover(context, 8);
      basico(context);        
    } else {
      mover(context, 3);
    }
  }  
}