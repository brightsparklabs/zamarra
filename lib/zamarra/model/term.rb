##
 # The Zamarra module contains a set of utlities for working with Zthes XML
 # documents
 # _____________________________________________________________________________
 #
 # Created by brightSPARK Labs
 # www.brightsparklabs.com
 ##

module Zamarra
    module Model

        ##
         # Models the 'term' tag in a Zthes XML document
         ##
        class Term

            # ------------------------------------------------------------------
            # INSTANCE VARIABLES
            # ------------------------------------------------------------------

            attr_reader :id, :children_ids, :children, :name

            # ------------------------------------------------------------------
            # PUBLIC METHODS
            # ------------------------------------------------------------------

            ##
             # Default constructor
             #
             # @param document [ZthesDocument]
             #          document to write
             ##
            def initialize(id, name)
                @id = id
                @name = name
                @children_ids = []
                @children = []
            end

            ##
             # Adds the supplied Zthes ID as a child under this Term
             #
             # @param id [String]
             #          Zthes ID of the child term
             ##
            def add_child_id(id)
                children_ids << id
            end

            ##
             # Adds the supplied term as a child under this Term
             #
             # @param child [Term]
             #          child term to add
             ##
            def add_child(child)
                children << child
            end
        end
    end
end
