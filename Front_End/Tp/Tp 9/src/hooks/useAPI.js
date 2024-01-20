import { useState, useEffect } from "react";
import axios from 'axios'
function useAPI() {
    const [data, setData] = useState([])
      useEffect(
        () =>{
          axios.get("https://run.mocky.io/v3/aaad4a55-6339-4b69-9940-5548e4014146").then((res) => {
            setData(res.data.eleves);
          })
        }, []
      );
      return data
}

export default useAPI