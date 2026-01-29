async function loadClasses() {
    const res = await fetch(`${API_BASE}/classes`);
    const data = await res.json();

    const body = document.getElementById("classBody");
    body.innerHTML = "";

    data.forEach(c => {
        body.innerHTML += `
            <tr>
                <td>${c.class_id}</td>
                <td>${c.class_name}</td>
            </tr>
        `;
    });
}

loadClasses();
