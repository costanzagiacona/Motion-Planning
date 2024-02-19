
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
  //VISTA
  if (keyCode == 'X') eyeX += 25;
  if (keyCode == 'x') eyeX -= 25;
  if (keyCode == 'Y') eyeY += 25;
  if (keyCode == 'y') eyeY -= 25;


  if (keyCode == ENTER)
  {
    if (semsp == true) //finito di creare lo spazio di lavoro passiamo alla creazione degli ostacoli
    {
      semsp = false;
      semost= true;
      x = 0;
      y = 0;
      orientamento = 0;
      incrost = 0 ;
    } else if (semsp == false) //finita la creazione degli ostacoli passiamo al grafo
    {
      semsp = false;
      semost= false;
    }
  }

  /*MODIFICA SPAZIO DI LAVORO*/
  if (semsp == true)
  {
    //println("SEMsp OSTACOLIIIIIIIIII AAAAAADENHFOIwehnfiohnweoifhoaerhgioehoifhweoiuhfgiueghfuiweghfiuweghfiuweghifugwehiufgweiuiwk");
    if (key == '+') //aumento dimensione spazio lavoro o ostacolo
    {
      incrsp += kp;
      if (incrsp > 100) incrsp=100;
    }

    if (key == '-') //diminuisco dimensione spazio lavoro o ostacolo
    {
      incrsp -= kp;
      if (incrsp < kp) incrsp = kp;
    }
  }

  /*MODIFICA OSTACOLI*/
  else if (semost == true)
  {
    //println("SEMOST OSTACOLIIIIIIIIII AAAAAADENHFOIwehnfiohnweoifhoaerhgioehoifhweoiuhfgiueghfuiweghfiuweghfiuweghifugwehiufgweiuiwk");
    //SEMINS 0
    if (semins == 0)
    {
      if (key == 'o')
      {
        x = 0;
        y = 0;
        orientamento = 0;
        incrost = 0 ;
        nfiguraost = 1;
        //Ostacolo_creazione(numero_ostacoli, x, y, 50+incrost, 50+incrost, orientamento, nfiguraost,coloreost);
        //ostacolo_ArrayList.get(numero_ostacoli).colore = false;
        //println("semins ->", semins, "x ->", x, "y->", y);
        semins = 1;
      }
    }



    //SEMINS 1
    if (semins == 1)
    {
      sovrapposizioneost = sovrapposizione(x, y, 50+incrost, 70+incrost, orientamento);

      if (key == '+') //aumento dimensione spazio lavoro o ostacolo
      {
        incrost += kp;
        if (incrost > 100) incrost = 100;
      }

      if (key == '-') //diminuisco dimensione spazio lavoro o ostacolo
      {
        incrost -= kp;
        if (incrost < kp) incrost = kp;
      }

      //orientamento ostacoli
      if (keyCode == RIGHT)
      {
        orientamento = orientamento + PI/24;
      }

      if (keyCode == LEFT)
      {
        orientamento = orientamento - PI/24;
      }
      //println("semins ->", semins, "x ->", x, "y->", y);

      if (key == 'w') semins = 2;
    }

     // sovrapposizioneost = sovrapposizione(x, y, 50+incrost, 70+incrost, orientamento);

    //SEMINS 2
    if (semins == 2)
    {
      //sovrapposizioneost = sovrapposizione(x, y, 50+incrost, 70+incrost, orientamento);

      if (keyCode == DOWN)
      {
        //posizione ostacolo
        y += 20; //posizione ostacolo
        //Non facciamo sporgere troppo l'ostacolo dal tavolo
       // if (y >= posxsp[nfigurasp-1] - (ostacolo_ArrayList.get(numero_ostacoli)).lato2) y = posxsp[nfigurasp-1] - (ostacolo_ArrayList.get(numero_ostacoli)).lato2;
      }

      if (keyCode == UP)
      {
        //posizione ostacolo
        y -= 20; //posizione ostacolo
        //Non facciamo sporgere troppo l'ostacolo dal tavolo
        //if (y <= -posxsp[nfigurasp-1] + (ostacolo_ArrayList.get(numero_ostacoli)).lato2) y = - posxsp[nfigurasp-1] + (ostacolo_ArrayList.get(numero_ostacoli)).lato2;
      }

      //orientamento ostacoli
      if (keyCode == RIGHT)
      {
        x += 20; //posizione ostacolo
        //Non facciamo sporgere troppo l'ostacolo dal tavolo
        //if (x >= posxsp[nfigurasp-1] - (ostacolo_ArrayList.get(numero_ostacoli)).lato1/2) x = posxsp[nfigurasp-1] - (ostacolo_ArrayList.get(numero_ostacoli)).lato1/2;
      }

      if (keyCode == LEFT)
      {
        x -= 20; //posizione ostacolo
        //Non facciamo sporgere troppo l'ostacolo dal tavolo
        //if (x <= -posxsp[nfigurasp-1] + (ostacolo_ArrayList.get(numero_ostacoli)).lato1/2) x = - posxsp[nfigurasp-1] + (ostacolo_ArrayList.get(numero_ostacoli)).lato1/2;
      }
      //println("semins ->", semins, "x ->", x, "y->", y);

      sovrapposizioneost = sovrapposizione(x, y, 50+incrost, 70+incrost, orientamento);
      
      if (keyCode == TAB)
      {
        if (!sovrapposizioneost) //ricominciamo e creiamo un nuovo ostacolo
        {
          //ostacolo_ArrayList.get(numero_ostacoli).colore = true;
          //println("cambio colore in true ->", ostacolo_ArrayList.get(numero_ostacoli).colore );
          numero_ostacoli++;
          if (numero_ostacoli >= MAX_OST) semost = false;
          Ostacolo_creazione(numero_ostacoli, x, y, 50+incrost, 50+incrost, orientamento, nfiguraost);
          
          //println("creazione nuovo ostacolo con valori -> semins ->", semins, "x ->", x, "y->", y);
          semins = 0;
        }
      }
    }

    //MODIFICA OSTACOLO
    /*sovrapposizioneost = sovrapposizione(x, y, 120+incrost, 100+incrost, orientamento);
     if (keyCode == TAB )//semaforo posizione ostacolo
     {
     //if (semost && semins == 1 && !sovrapposizioneost) semins = 2;  //da dimensione e orientamento ostacolo passiamo alla posizione
     //else if (semost && semins == 2 && !sovrapposizioneost) //ricominciamo e creiamo un nuovo ostacolo
     if (semost && semins == 2 && !sovrapposizioneost) //ricominciamo e creiamo un nuovo ostacolo
     {
     numero_ostacoli++;
     if (numero_ostacoli >= MAX_OST) semost = false;
     Ostacolo_creazione(numero_ostacoli, x, y, 50+incrost, 50+incrost, orientamento, nfiguraost);
     println("creazione nuovo ostacolo con valori -> semins ->", semins, "x ->", x, "y->",  y);
     semins = 0;
     }
     }*/
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
