module TradesHelper
    def find_service(id, field)
        service = Service.find_by(service_id: id)
        data = ''
        case field
        when 'name'
            data = service.name
        when
            data = 
        end

        data
    end
end
