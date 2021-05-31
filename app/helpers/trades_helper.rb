module TradesHelper

    def info(data, id, sym)
        data.find{|record| record[:id] == id}[sym]
    end
end
