<template>
  <div id="app">
   
    <img width="100" src="https://elandroidelibre.elespanol.com/wp-content/uploads/2013/05/games_controller_green.jpg">
  
  <!--   <HelloWorld msg="Welcome to Your Vue.js App"/> 
  -->
    <h1> --- Juegos ---</h1>

    <form v-on:submit.prevent="addJuego">
      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label>Nombre:</label>
            <input type="text" class="form-control" v-model="juego.nombre"/>
          </div>
        </div>
        </div>

      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label>Plataforma:</label>
            <input type="text" class="form-control" v-model="juego.plataforma"/>
          </div>
        </div>
        </div>

        <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label>Genero:</label>
            <input type="text" class="form-control" v-model="juego.genero"/>
          </div>
        </div>
        </div>

      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label>Precio:</label>
            <input type="text" class="form-control" v-model="juego.precio"/>
          </div>
        </div>
        </div>

      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label>exist:</label>
            <input type="text" class="form-control" v-model="juego.exist"/>
          </div>
        </div>
        </div>
       
       <br />
        <div class="form-group">
          <button class="btn btn-primary">Agregar Juego</button>
        </div>
      <br/>
           
    </form>
      <div class="form-group">

          <button @click="updateJuego()">
              Actualizar Juego
          </button>
        </div>

  <ul v-if="posts && posts.length">
    <li v-for="juego of posts">
       {{ juego.id }} - 
       {{ juego.nombre }}
              <button @click="getonejuego(juego.id)">
                Editar
     </button>
     <button @click="deleteJuego(juego.id)">
                Eliminar
     </button>
    </li>
  </ul>

  <ul v-if="errors && errors.length">
    <li v-for="error of errors">
      {{error.message}}
    </li>
  </ul>
  </div>

</template>

<script>
// import HelloWorld from './components/HelloWorld.vue' 
import axios from 'axios';

export default {
  name: 'app',
  data() {
    return {
      juego: {},
      posts: [],
      errors: []
    }
  },
  created() {
    // Fetches posts when the component is created.
    this.getjuego();
 
  } ,
  methods: {
 
  getjuego() {
    axios.get('http://35.227.59.176:8080/api/juegos')
    .then(response => {
      // JSON responses are automatically parsed.
      this.posts = response.data
    })
    .catch(e => {
      this.errors.push(e)
    })
  },

  getonejuego(idjuego) {
    axios.get('http://35.227.59.176:8080/api/juegos/'+ idjuego)
    .then(response => {
      // JSON responses are automatically parsed.
      this.juego = response.data
      alert("status: " + response.status + ", selected: " + JSON.stringify(response.data));

    })
    .catch(e => {
      this.errors.push(e)
    })
  },

  addJuego() {
    alert(this.juego.nombre + this.juego.plataforma + this.juego.genero + this.juego.precio + this.juego.exist);
    axios.post('http://35.227.59.176:8080/api/juegos',  this.juego)
    .then(response => {
      alert("status: " + response.status + ", inserted: " + JSON.stringify(response.data));
    })
    .catch(e => {
      this.errors.push(e)
    })
  },
  
  updateJuego() {
    //alert(idjuego);
    alert(this.juego.id);
    axios.put('http://35.227.59.176:8080/api/juegos/' + this.juego.id,
      this.juego)
    .then(response => {
      alert("status: " + response.status + ", updated: " + JSON.stringify(response.data));
      this.getjuego();

    })
    .catch(e => {
      this.errors.push(e)
    })
  },
  

  deleteJuego(idjuego) {
    alert("delete" + idjuego);
    
    axios.delete('http://35.227.59.176:8080/api/juegos/' + idjuego)
    .then(response => {

      alert("status: " + response.status + ", deleted: " + JSON.stringify(response.data));
      this.getjuego();

    })
    .catch(e => {
      this.errors.push(e)
    })
  },
  
  }

}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
