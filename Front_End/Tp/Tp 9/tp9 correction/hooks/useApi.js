import { useState, useEffect } from "react";
import axios from 'axios';
function useApi() {
    const [eleves, setEleves] = useState([]);
    useEffect(() => axios.get("https://run.mocky.io/v3/c5afb965-fb73-4478-86e6-2fd906e0eeff").then((res) => { setEleves(res.data.eleves) }), []);
    return eleves;
}
export default useApi;