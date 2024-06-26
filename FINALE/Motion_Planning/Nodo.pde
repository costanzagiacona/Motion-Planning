class Nodo
{
  public ArrayList<Nodo> links = new ArrayList<Nodo>(); //rami collegati al nodo
  public String label; //numero nodo
  public int id; //indice nodo

  public float x; //posizione nodo
  public float y;
  public float r; //raggio nodo
  public Nodo padre; //nodo padre

  public boolean visitato = false;

  //METODI

  //Funzione che crea il nodo
  /* Le coordinate _x e _y sono prese rispetto a SR0 */
  Nodo(String _label, float _x, float _y, int _id)
  {
    label=_label;
    x=_x;
    y=_y;
    id = _id;
  }

  //verifica se nodo esiste in una certa posizione
  public boolean equals(Object obj)
  {
    //se esiste nodo                     e    se le posizioni sono uguali
    return (this.label.equals(((Nodo)obj).label) && this.x == (((Nodo)obj).x) && this.y == (((Nodo)obj).y));
  }


  //aggiunto nodo alla lista dei collegamenti
  void addLink(Nodo n)
  {
   if (!links.contains(n))
    {
      links.add(n);
    }
 // links.add(n);
  }

  //restituisce i nodi in links  --------------------------------------------------- da vedere questa e quando usiamo le altre
  ArrayList<Nodo> getIncomingLinks() {
    return links;
  }


  //restituisce la dimensione della lista, quindi il numero dei nodi
  int getLinksCount() {
    return links.size();
  }
}
