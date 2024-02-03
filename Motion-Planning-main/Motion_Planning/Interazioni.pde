
void mouseDragged() {
  angoloY = angoloYpartenza - PI*mouseX/float(1000); //DA MODIFICARE <===  !!!!!!
  angoloX = angoloXpartenza - PI*mouseY/float(1000);
}

void keyPressed()
{
  if (semsp) //CAMBIO FIGURA SPAZIO DI LAVORO
  {
    if (keyCode == '1') nfigurasp = 1; //quadrato
    if (keyCode == '2') nfigurasp = 2; //rettangolo
    if (keyCode == '3') nfigurasp = 3; //rombo
    if (keyCode == '4') nfigurasp = 4; //cerchio
    if (keyCode == '5') nfigurasp = 5; //triangolo
    if (keyCode == '6') nfigurasp = 6; ///trapezio
  }

  if (semost) //CAMBIO FIGURA OSTACOLI
  {
    if (keyCode == '1') nfiguraost = 1; //quadrato
    if (keyCode == '2') nfiguraost = 2; //rettangolo
    if (keyCode == '3') nfiguraost = 3; //rombo
    if (keyCode == '4') nfiguraost = 4; //cerchio
    if (keyCode == '5') nfiguraost = 5; //triangolo
    if (keyCode == '6') nfiguraost = 6; ///trapezio
  }

  if (keyCode == 'X') eyeX += 25;
  if (keyCode == 'x') eyeX -= 25;
  if (keyCode == 'Y') eyeY += 25;
  if (keyCode == 'y') eyeY -= 25;

  if (key == '+')
  {
    if(semsp) incrsp += kp;
    if (incrsp > 100) incrsp=100;
    if(semost) incrost += kp;
    if (incrost > 100) incrost=100;
  }

  if (key == '-')
  {
    if(semsp) incrsp -= kp;
    if (incrsp < kp) incrsp = kp;
    if(semost) incrost -= kp;
    if (incrost < kp) incrost = kp;
  }
  
  if(key == ' ') sempos = true; //semaforo posizione ostacolo
  
  if(keyCode == UP)
  {
    if(sempos) y += 20; //posizione ostacolo
  }
  
  if(keyCode == DOWN)
  {
    if(sempos) y -= 20; //posizione ostacolo
  }
  
  //orientamento ostacoli
  if (keyCode == RIGHT) 
  {
    if(!sempos) orientamento = orientamento + PI/24;
    if(sempos) 
    {
    x += 20; //posizione ostacolo
    println(x);
    println(nfigurasp); //numero corretto
    println(posxsp[nfigurasp]);
    if(x > posxsp[nfigurasp]) x = posxsp[nfigurasp];
    }
  }
  
  if (keyCode == LEFT)  
  {
    if(!sempos) orientamento = orientamento - PI/24;
    if(sempos) x -= 20; //posizione ostacolo
  }
  
  
  
  //quando preme o termina l'inserimento degli ostacoli
  if(keyCode == 'o') semins = false;

  if (keyCode == ENTER)
  {
    if (semsp == true)
    {
      semsp = false;
      semost= true;
    } 
    else if (semsp == false)
    {
      semsp = false;
      semost= false;
    }
  }
  
  
  //DA MODIFICARE
  // visual home
  if (key == 'h') {
    angoloX = 0;
    angoloY = 0;
    angoloXpartenza = 0;
    angoloYpartenza = 0;
  }
}
