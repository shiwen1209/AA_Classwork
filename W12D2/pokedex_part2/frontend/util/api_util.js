export const fetchAllPokemon = () => {
  return $.ajax({
    method: "GET",
    url: "/api/pokemon"
  })
}

export const fetchPokemon = (id) =>{
  console.log("util")
  console.log(id)

  return $.ajax({
    method: "GET",
    url: `/api/pokemon/${id}`
  })
}