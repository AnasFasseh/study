import { Div } from "./Div";
import { Nom } from "./Nom";
import { Fonction } from "./Fonction";
import { Adresse } from "./Adresse";
export default function CarteVisite(props) {
  return (
    <Div>
      <Nom>{props.nom}</Nom>
      <Fonction>{props.fonction}</Fonction>
      <Adresse>
        Tél:{props.tel} {props.adresse}
      </Adresse>
    </Div>
  );
}
