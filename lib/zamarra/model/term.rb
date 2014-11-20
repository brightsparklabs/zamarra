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

            attr_reader :id, :children_ids, :children, :name, :synonyms

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
                @synonyms = []
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

            ##
             # Adds the supplied synonym to this Term
             #
             # @param synonym [Term]
             #          synonym to add
             ##
            def add_synonym(synonym)
                synonyms << synonym
            end
        end
    end
end
