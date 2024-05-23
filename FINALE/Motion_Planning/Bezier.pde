// Legge a minima energia per lo spostamento tra un punto e il successivo
int num_nodi_b = 0;
ArrayList<Float> punti_bezier = new ArrayList<Float>();
boolean sembezier = false;
ArrayList<Float> curva_bezier = new ArrayList<Float>();


void bezier_function()
{
  num_nodi_b = nodi_visitati_bezier.size(); // conta da 1 e non da 0
  float a1, b1, c1, d1;  // coordinate punti di controllo
  //nodo_successivo = nodi_visitati_bezier.get(1);
  //a1 = (d.x + nodo_successivo.x)/2 + 15;
  //b1 = (root.y + nodo_successivo.y)/2 + 15;
  a1 = root.x;
  b1 = root.y;
  c1 = a1;
  d1 = b1;
  float dx, dy;
  int n = 80; //segmenti per ogni retta
  float[] punti_intermedi = new float[2*n];

  noFill();
  stroke(0, 0, 255); // blu
  if (num_nodi_b == 1) //c'è solo source e trova subito target
  {
    //per calcolare punti intermedi
    nodo_corrente = root;
    dx = xot - nodo_corrente.x;
    dy = yot - nodo_corrente.y;
    float dx_int = dx / (n + 1);
    float dy_int = dy / (n + 1);

    punti_intermedi[0] = nodo_corrente.x;
    punti_intermedi[1] = nodo_corrente.y;

    for (int k = 2; k < 2*n; k = k+2)
    {
      punti_intermedi[k] = punti_intermedi[k-2] + dx_int;
      punti_intermedi[k+1] = punti_intermedi[k-1] + dy_int;

      //println("punti intermedi ->", k, punti_intermedi[k], punti_intermedi[k+1]);
      //stroke(0,0,255);
      //ellipse(nodo_successivo.x, nodo_successivo.y,20, 10);
      //stroke(255,0,0);
      //ellipse(punti_intermedi[8],punti_intermedi[9],20, 10);
    }

    for (int k = 0; k < 2*n-2; k = k+2)
    {
      c1 = -a1 + (2*punti_intermedi[k+2]);
      d1 = -b1 + (2*punti_intermedi[k+3]);
      for (float l = 0; l < 1; l = l+0.1) {
        // curva di bezier
        float x = pow((1-l), 2)*punti_intermedi[k]+2*(1-l)*l*a1+pow(l, 2)*punti_intermedi[k+2];
        float y = pow((1-l), 2)*punti_intermedi[k+1]+2*(1-l)*l*b1+pow(l, 2)*punti_intermedi[k+3];

        //stroke(100+10*k, 100-50*k, 100+20*k);
        stroke(0, 0, 255);
        point(x, y);

        if (curva_bezier.size() <= (k+1)*(2*n+2)) //aggiungiamo nodi solo se inferiori a 50 + inizio + fine
        {
          //println("INSERISCO PUNTI SEGMENTO", i);
          curva_bezier.add(x);
          curva_bezier.add(y);
        }
      }

      a1 = c1;
      b1 = d1;
      //stroke(0, 255, 0);
      //ellipse(c1, d1, 10, 15);
    }
    //disegna ultima curva tra 79-esimo punto e 80-esimo
    c1 = -a1 + (2*xot);
    d1 = -b1 + (2*yot);
    println(nodo_successivo.label);
    for (float l = 0; l < 1; l = l+0.1) {
      float x = pow((1-l), 2)*punti_intermedi[2*n-2]+2*(1-l)*l*a1+pow(l, 2)*xot;
      float y = pow((1-l), 2)*punti_intermedi[2*n-1]+2*(1-l)*l*b1+pow(l, 2)*yot;
      stroke(0, 0, 255);
      point(x, y);

      if (curva_bezier.size() < (2*n+2)) //aggiungiamo nodi solo se inferiori a 80 + inizio + fine
      {
        // println("INSERISCO PUNTI SEGMENTO 79-80", i);
        curva_bezier.add(x);
        curva_bezier.add(y);
      }
    }

    a1 = c1;
    b1 = d1;
  } else //c'è almeno un nodo in più oltre source
  {
    //println(bez, "line");
    for (int i = 0; i < num_nodi_b-1; i++)
    {

      nodo_corrente = nodi_visitati_bezier.get(i);
      nodo_successivo = nodi_visitati_bezier.get(i+1);

      //per calcolare punti intermedi
      dx = nodo_successivo.x - nodo_corrente.x;
      dy = nodo_successivo.y - nodo_corrente.y;
      float dx_int = dx / (n + 1);
      float dy_int = dy / (n + 1);

      punti_intermedi[0] = nodo_corrente.x;
      punti_intermedi[1] = nodo_corrente.y;

      for (int k = 2; k < 2*n; k = k+2)
      {
        punti_intermedi[k] = punti_intermedi[k-2] + dx_int;
        punti_intermedi[k+1] = punti_intermedi[k-1] + dy_int;

        //println("punti intermedi ->", k, punti_intermedi[k], punti_intermedi[k+1]);
        //stroke(0,0,255);
        //ellipse(nodo_successivo.x, nodo_successivo.y,20, 10);
        //stroke(255,0,0);
        //ellipse(punti_intermedi[8],punti_intermedi[9],20, 10);
      }

      if (i == 0) //source
      {
        a1 = (nodo_corrente.x + punti_intermedi[2])/2;
        b1 = (nodo_corrente.y + punti_intermedi[3])/2;
      }

      for (int k = 0; k < (2*n)-2; k = k+2)
      {
        c1 = -a1 + (2*punti_intermedi[k+2]);
        d1 = -b1 + (2*punti_intermedi[k+3]);
        for (float l = 0; l < 1; l = l+0.1) {
          // curva di bezier
          float x = pow((1-l), 2)*punti_intermedi[k]+2*(1-l)*l*a1+pow(l, 2)*punti_intermedi[k+2];
          float y = pow((1-l), 2)*punti_intermedi[k+1]+2*(1-l)*l*b1+pow(l, 2)*punti_intermedi[k+3];

          //stroke(100+10*k, 100-50*k, 100+20*k);
          stroke(0, 0, 255);
          point(x, y);
        
          if (curva_bezier.size() <= (k+1)*(10*n+2)) //aggiungiamo nodi solo se inferiori a 50 + inizio + fine
          {
            println("INSERISCO PUNTI SEGMENTO", i);
            curva_bezier.add(x);
            curva_bezier.add(y);
          }
        }

        a1 = c1;
        b1 = d1;
        //stroke(0, 255, 0);
        //ellipse(c1, d1, 10, 15);
      }
      //disegna ultima curva tra 79-esimo punto e 80-esimo
      c1 = -a1 + (2*nodo_successivo.x);
      d1 = -b1 + (2*nodo_successivo.y);
      for (float l = 0; l < 1; l = l+0.1) {
        float x = pow((1-l), 2)*punti_intermedi[2*n-2]+2*(1-l)*l*a1+pow(l, 2)*nodo_successivo.x;
        float y = pow((1-l), 2)*punti_intermedi[2*n-1]+2*(1-l)*l*b1+pow(l, 2)*nodo_successivo.y;
        stroke(0, 0, 255);
        point(x, y);

        if (curva_bezier.size() < (num_nodi_b-1)*(10*n+2)) //aggiungiamo nodi solo se inferiori a 80 + inizio + fine
        {
          println("INSERISCO PUNTI SEGMENTO 79-80", i);
          curva_bezier.add(x);
          curva_bezier.add(y);
        }
      }

      a1 = c1;
      b1 = d1;

      //stroke(1*i, 50*i, 55); // blu
    }

    // ultimo collegamento con target
    nodo_corrente = nodi_visitati_bezier.get(num_nodi_b-1);
    dx = xot - nodo_corrente.x;
    dy = yot - nodo_corrente.y;
    float dx_int = dx / (n + 1);
    float dy_int = dy / (n + 1);

    punti_intermedi[0] = nodo_corrente.x;
    punti_intermedi[1] = nodo_corrente.y;
    for (int k = 2; k < 2*n; k = k+2)
    {
      punti_intermedi[k] = punti_intermedi[k-2] + dx_int;
      punti_intermedi[k+1] = punti_intermedi[k-1] + dy_int;

      //println("punti intermedi ->", k, punti_intermedi[k], punti_intermedi[k+1]);
    }

    for (int k = 0; k < 2*n-2; k = k+2)
    {
      c1 = -a1 + (2*punti_intermedi[k+2]);
      d1 = -b1 + (2*punti_intermedi[k+3]);
      for (float l = 0; l < 1; l = l+0.1) {

        // curva di bezier
        float x = pow((1-l), 2)*punti_intermedi[k]+2*(1-l)*l*a1+pow(l, 2)*punti_intermedi[k+2];
        float y = pow((1-l), 2)*punti_intermedi[k+1]+2*(1-l)*l*b1+pow(l, 2)*punti_intermedi[k+3];

        //stroke(100+10*k, 100-50*k, 100+20*k);
        stroke(0, 0, 255);
        point(x, y);

        if (curva_bezier.size() <= (k+1)*(10*n+2)) //aggiungiamo nodi solo se inferiori a 50 + inizio + fine
        {
          println("INSERISCO PUNTI TARGET", k);
          curva_bezier.add(x);
          curva_bezier.add(y);
        }
      }
      a1 = c1;
      b1 = d1;
      //stroke(0, 255, 0);
      //ellipse(c1, d1, 10, 15);
    }
    //disegna ultima curva tra 79-esimo punto e 80-esimo
    c1 = -a1 + (2*xot);
    d1 = -b1 + (2*yot);
    for (float l = 0; l < 1; l = l+0.1) {
      float x = pow((1-l), 2)*punti_intermedi[2*n-2]+2*(1-l)*l*a1+pow(l, 2)*xot;
      float y = pow((1-l), 2)*punti_intermedi[2*n-1]+2*(1-l)*l*b1+pow(l, 2)*yot;
      stroke(0, 0, 255);
      point(x, y);

      if (curva_bezier.size() < (num_nodi_b)*(10*n+2)) //aggiungiamo nodi solo se inferiori a 50 + inizio + fine
      {
        println("INSERISCO PUNTI TARGET 79-80");
        curva_bezier.add(x);
        curva_bezier.add(y);
      }
    }

    a1 = c1;
    b1 = d1;

    //stroke(1*i, 50*i, 55); // blu
  }
}

int binomio(int n, int k)
{
  if (k < 0 || k > n) {
    return 0;
  }
  int[][] dp = new int[n + 1][k + 1];
  for (int i = 0; i <= n; i++) {
    for (int j = 0; j <= min(i, k); j++) {
      if (j == 0 || j == i) {
        dp[i][j] = 1;
      } else {
        dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
      }
    }
  }
  return dp[n][k];
}
