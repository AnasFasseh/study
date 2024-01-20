import { useState } from 'react';
import useApi from './hooks/useApi';
function App() {
  const [code, setCode] = useState('');
  const [nom, setNom] = useState('');
  const [age, setAge] = useState('');
  const [groupe, setGroupe] = useState('');
  const eleves = useApi();
  const [feleves, setFeleves] = useState(eleves);
  function handlerClick() {
    const eleve = eleves.filter((elv) => elv.code === parseInt(code));
    if (eleve[0]) {
      setNom(eleve[0].nom);
      setAge(eleve[0].age);
      setGroupe(eleve[0].groupe);
      setFeleves(eleve);
    }
    else {
      setNom('');
      setAge('');
      setGroupe('');
      setFeleves(eleves);
      alert("Elève introuvable!");
    }
  }
  function filtrer() {
    const releve = eleves.filter((elv) => elv.groupe === groupe);
    setFeleves(releve);
  }
  return <div>
    <h1>Nombre d'élèves :{eleves.length}</h1>
    <form onSubmit={(e) => e.preventDefault()}>
      <p>Code:<input type="text" value={code} onChange={(e) => setCode(e.target.value)} /></p>
      <p>Nom:<input type="text" value={nom} onChange={(e) => setNom(e.target.value)} /></p>
      <p>Age:<input type="text" value={age} onChange={(e) => setAge(e.target.value)} /></p>
      <p>Groupe:<input type="text" value={groupe} onChange={(e) => setGroupe(e.target.value)} /></p>
      <button onClick={() => handlerClick()}>Rechercher</button>
      <button onClick={() => filtrer()}>Filtrer</button>
      <button onClick={() => setFeleves(eleves)}>Initialiser</button>

    </form>
    <table border="1">
      <tr>
        <th>Code</th><th>Nom</th><th>Age</th><th>Groupe</th>
      </tr>
      {
        (feleves.length !== 0 ? feleves : eleves).map((eleve, index) => <tr key={index}>
          <td>{eleve.code}</td><td>{eleve.nom}</td>
          <td>{eleve.age}</td><td>{eleve.groupe}</td>
        </tr>)
      }
    </table>
  </div>

}
export default App;
