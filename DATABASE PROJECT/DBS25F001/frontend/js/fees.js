fetch("http://localhost:4567/fee-structure")
    .then(res => res.json())
    .then(data => {

        let table = document.getElementById("feeTable");
        table.innerHTML = "";

        data.forEach(f => {
            table.innerHTML += `
                <tr>
                    <td>${f.fee_id}</td>
                    <td>${f.fee_type_id}</td>
                    <td>${f.amount}</td>
                </tr>
            `;
        });
    });
