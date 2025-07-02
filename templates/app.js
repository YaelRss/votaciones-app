// 1. Cargar votaciones al iniciar
document.addEventListener('DOMContentLoaded', cargarVotaciones);

async function cargarVotaciones() {
    try {
        const response = await fetch('http://localhost:3000/api/votaciones/activas');
        const votaciones = await response.json();
        
        const container = document.getElementById('votaciones-container');
        container.innerHTML = '';
        
        votaciones.forEach(votacion => {
            const div = document.createElement('div');
            div.className = 'votacion';
            div.innerHTML = `
                <h3>${votacion.pregunta}</h3>
                <p>Total votos: ${votacion.total_votos || 0}</p>
                <button onclick="cargarOpciones(${votacion.id})">Ver opciones</button>
            `;
            container.appendChild(div);
        });
    } catch (error) {
        console.error("Error al cargar votaciones:", error);
    }
}

// 2. Cargar opciones para votar
async function cargarOpciones(idVotacion) {
    try {
        const response = await fetch(`http://localhost:3000/api/votaciones/${idVotacion}`);
        const votacion = await response.json();
        
        const select = document.getElementById('opciones-votar');
        select.innerHTML = '<option value="">Selecciona una opción</option>';
        
        votacion.opciones.forEach(opcion => {
            const option = document.createElement('option');
            option.value = opcion.id;
            option.textContent = `${opcion.texto} (${opcion.votos} votos)`;
            select.appendChild(option);
        });
    } catch (error) {
        console.error("Error al cargar opciones:", error);
    }
}

// 3. Manejar el voto
document.getElementById('form-votar').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const idUsuario = document.getElementById('id-usuario').value;
    const idOpcion = document.getElementById('opciones-votar').value;
    
    try {
        const response = await fetch('http://localhost:3000/api/votaciones/votar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id_usuario: idUsuario,
                id_opcion: idOpcion
            })
        });
        
        const result = await response.json();
        
        if (result.success) {
            alert("¡Voto registrado!");
            cargarVotaciones(); // Actualizar lista
        } else {
            alert(result.error || "Error al votar");
        }
    } catch (error) {
        console.error("Error:", error);
        alert("Error de conexión");
    }
});