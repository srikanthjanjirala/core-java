// Product class
public class House {
    private String foundation;
    private String structure;
    private String roof;
    private boolean furnished;

    private House(Builder builder) {
        this.foundation = builder.foundation;
        this.structure = builder.structure;
        this.roof = builder.roof;
        this.furnished = builder.furnished;
    }

    public static class Builder {
        private String foundation;
        private String structure;
        private String roof;
        private boolean furnished;

        public Builder setFoundation(String foundation) {
            this.foundation = foundation;
            return this;
        }

        public Builder setStructure(String structure) {
            this.structure = structure;
            return this;
        }

        public Builder setRoof(String roof) {
            this.roof = roof;
            return this;
        }

        public Builder setFurnished(boolean furnished) {
            this.furnished = furnished;
            return this;
        }

        public House build() {
            return new House(this);
        }
    }

    @Override
    public String toString() {
        return "House [foundation=" + foundation + ", structure=" + structure + 
               ", roof=" + roof + ", furnished=" + furnished + "]";
    }
}

public class BuilderPatternMain {
    public static void main(String[] args) {
        House house = new House.Builder()
            .setFoundation("Concrete")
            .setStructure("Wood and Brick")
            .setRoof("Shingles")
            .setFurnished(true)
            .build();

        System.out.println(house);
    }
}
