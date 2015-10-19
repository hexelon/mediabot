# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
  GoogleSpreadsheet = require('google-spreadsheet');

  creds = {
    client_email: '567197012795-u5p0806kanbf8c981pg0hilpc53fkbuv@developer.gserviceaccount.com',
    private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDwwlZrx6gvf1PT\nKI1M6RK2/W0lONh+aJ5tyVhq6GcwKjvmkRDwkOFaBESELmzIF/ntsNFA9V33UlVn\nCHN73ZO/qNjataecEX/S+whe78aPKEMP1QiMOv0NmMs+jMfIKt3D2X99ePpLzlGf\nQ1Hk4KWzgD7v4KueqUN7KAbWAgE9X2mqr9MrunamSIneuKT9q9bb2yL4sqwIDUCI\nHYqQt2p1jWct1TUG051Ad0qr3JojZwlli4xsIERB7sHNiDGmB6gigdH7nsaR9+Sf\nrD2I1FoBnm526pGoNq7UK0X7gNuNQkenVXCmrQETby/pyV+Op4SJnb4px4HjDcvP\njbidMUepAgMBAAECggEBAJXJAkU5yQwL1lXnw8kWtFr+XhorPJ2gbvh0rLqObixM\nCkpO9FAGgv0i7JGj5G+0Yvya5gTY4qYNJi7c1iQ43UP/QzMGkwmI5ZKYNUQDPvAv\np1FBQ3ki9e6wobn/kgeZi7DeLvAcBPSGnsdL9bZEgTKk1gMdLwid2+rSIzaftq+7\n6KfBKGthNpDzWXpV3V/AfVC1IB56Iz6EY31GKZy3tdy6xHx8YEc22+T4LJ0q13sr\nlMf2RaUuprdzCpeF3TaJT/UUzLk9oiWBrGS8VtWQGfPS7S/jfUPNATHoGNzZjYI5\nJTjd0TkMOlSdEs7jvepRQRlzqce2rRdMBBWrMoRYvRUCgYEA/IeB+MfC5k9ZiS/i\nfaLF5seVcxvVWCYwjbpCbLf+bQ6NV/6L5Ad082SbMrn/ocKbIp02dNT9ZDNa4CCN\negFjMj48fP7+tHhLbSwv7whmehHiBgCvbBf8zpnRn76dhN03tAzitjQln8SY2Pfa\nhC185w9fLh9Y7q9b8zxy7/SKBVsCgYEA9BFq/l7CEEw5BOd5Zp1yVakUgEEO0V6t\nkIGCcZeXjWT8sulv5nhSNLmiYfY5Vn7G11ifPuK8W5oCbgNLq3qVqjWWW//0/lWM\nVUFDo1vDH4vMmcT0eR43ZVYP+H62ASE0MFMyl1geMPaWjVGKhNJOk6QEkK9h1J6Y\nNs6LAFDVAksCgYEA2iKnl+HerplOi12MtN/9OUugAi3BzYI3oMWLCWSqZ0QRvjgI\nWPJECNcX5OqcMfvrjCvnVWaCd6KQ1lfoPcKjEEyIbaTLGdNrvCNWSJGmC74U0wCW\nh7X0z/Y5CFdcs99vdZ1H3QIQmgD10z3OSS0N3n39xtaXOJ7Lu8G0uygubU8CgYAs\nOz/dq4SV+YpX1i9NJnmDBqpdd+zcisD/sEjYlzVy/XtCXUXXSbT0MzQ3dqz7fOxC\nOKBbgDHMlAOetmAvSn73ItEGCUP4F77f8Hz2jPm2rNo+f9AiZxR4+/jW+ve3CrJv\nk5RWkzSdgQLVx5JH8eklnpLpOa+MHdXOEO5l90AzMwKBgGzPyDO46v2yOosHMRjx\nmo4Na4Eb/gZ4n8nJab2B46+WL0Dq+mxehcdd2RUU7SZSIO5qQVqX++nLUQzZCaod\nIUmjTavHpiDhjVWDWEdZjbquBvvimZdtOgGBOIdLuYZGoFQ6dECAnnI1a2nBVGga\nhdIlI/h0zFN439G0QPREH8KB\n-----END PRIVATE KEY-----\n",
  }

  robot.respond /contact (.+)/i, (res) ->
    contacts_sheet = new GoogleSpreadsheet('1rfyXOIh-LnrLy87aC8sH7XfqWgaontkLBpH24Hlc4k8')

    contact_name = res.match.slice(1).join(" ").toLowerCase();

    contacts_sheet.useServiceAccountAuth(creds, (err) ->
      if(err)
        return res.reply errupl

      contacts_sheet.getInfo( ( err, sheet_info ) ->
        contacts_sheet = sheet_info.worksheets[0];

        contacts_sheet.getRows(( err, rows ) ->
          found_contact = null
          rows.forEach((row) ->
            found_contact = row if row.name.toLowerCase().substr(0, contact_name.length) == contact_name
          )

          if found_contact != null
            res.reply "Name: " + found_contact.name + " Phone: " + found_contact.phone + " Email: " + found_contact.email
          else
            res.reply "No contact with this name found"

        );

        res.reply sheet_info.title + ' is loaded'
      )
    )




