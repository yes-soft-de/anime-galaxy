import { HttpEventType } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { ListCategory } from 'src/app/pages/categories/entity/list-category';
import { ListCategoryResponse } from 'src/app/pages/categories/entity/list-category-response';
import { CategoryService } from 'src/app/pages/categories/services/category.service';
import { ImageSnippet } from '../../entity/image-snippet';
import { AnimeService } from '../../services/anime.service';

@Component({
  selector: 'app-add-anime',
  templateUrl: './add-anime.component.html',
  styleUrls: ['./add-anime.component.scss']
})
export class AddAnimeComponent implements OnInit {
  allCategories: ListCategory[];
  generalRating = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  imageName = 'Select Image';
  fileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  imagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;

  constructor(private animeService: AnimeService,
              private categoryService: CategoryService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    
    this.categoryService.allCategories().subscribe(
      (categories: ListCategoryResponse) => {
        this.allCategories = categories.Data
      }, error => console.log(error)
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', [Validators.required, Validators.minLength(2), Validators.maxLength(45)]],
      mainImage: [''],
      description: ['', [Validators.required, Validators.minLength(2)]],
      trailerVideo: ['', [Validators.required, Validators.minLength(2)]],
      episodesCount: ['', Validators.required],
      publishDate: ['', Validators.required],
      categoryID: ['', Validators.required],
      ageGroup: ['', Validators.required],
      generalRating: ['', Validators.required],
      // suggest: ['', Validators.required]
    });
  }

  // Choose State Using Select Dropdown
  changeCategory(event) {
    this.uploadForm.get('categoryID').setValue(event.target.value, {
      onlySelf : true
    });
  }


  changeGeneralRating(event) {
    this.uploadForm.get('generalRating').setValue(event.target.value, {
      onlySelf : true
    });
  }

  // Choose If Globally Recommended Enimy 
  // changeSuggest(event) {
  //   this.uploadForm.get('suggest').setValue(event.target.value, {
  //     onlySelf: true
  //   });
  // }


  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();
    
    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'New Anime';        
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      // formObject.suggest = this.uploadForm.value.suggest == 1 ? true : false;
      formObject.mainImage = this.imageUrl;     
      this.animeService.createAnime(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }


}
