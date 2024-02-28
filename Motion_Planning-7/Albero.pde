class Albero  
{

  Nodo radice; //radice albero

  Albero(Nodo r) 
  {
    radice = r;
    nodo.add(radice); //inizializzato in MP 5
  }
  //AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  /*
  void addNodo(Nodo nodo) 
  {
    if (!nodo.contains(nodo)) 
    {
      nodo.add(nodo);
    }
  }
 */
 
  void rimuovoNodo(int index)
  {
    Nodo n = nodo.get(index);
    for (Nodo linked_node_i : n.getIncomingLinks()){
      linked_node_i.getIncomingLinks().remove(n);
    }
    nodo.remove(index);
  }
  
  
  Nodo getRoot() {
    return radice;
  }
  
  int size() {
    return nodo.size();
  }
  
  Nodo getNode(int index) {
    return nodo.get(index);
  }
  
  ArrayList<Nodo> getNodes() {
    return nodo;
  }
  
  boolean linkNodes(Nodo n1, Nodo n2) {
    if (nodo.contains(n1) && nodo.contains(n2)) {
      n1.addLink(n2);
      n2.addLink(n1);
      return true;
    }
    return false;
  }

  void addChild(Nodo parent, Nodo child) 
  {
    nodo.add(child);
    child.padre = parent;
    linkNodes(parent, child);
  }
  
}
